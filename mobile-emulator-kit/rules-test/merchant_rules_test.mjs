import {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} from '@firebase/rules-unit-testing';
import { doc, setDoc, updateDoc, getDoc } from 'firebase/firestore';
import { readFileSync } from 'node:fs';

const STORE = 'store_kunefeci_saim';
const OWNER = 'uid_merchant';
const OTHER = 'uid_other';
const VOTER = 'uid_ayse';

const env = await initializeTestEnvironment({
  projectId: 'savehatay',
  firestore: {
    rules: readFileSync('firestore.rules', 'utf8'),
    host: '127.0.0.1',
    port: 8765,
  },
});

await env.clearFirestore();

await env.withSecurityRulesDisabled(async (ctx) => {
  const db = ctx.firestore();
  await setDoc(doc(db, 'approvedApplications', STORE), {
    name: 'Kunefeci Saim Usta',
    ownerId: OWNER,
    isApproved: true,
    visitCount: 10,
    description: 'eski',
    images: [],
    phone: '0326',
    address: 'Ulus',
    category: { name: 'Tatlici', value: 12 },
    isCommentEnabled: true,
    showcaseModules: [],
  });
  await setDoc(doc(db, 'approvedApplications', STORE, 'votes', VOTER), {
    voterUid: VOTER,
    score: 5,
    comment: 'harika',
  });
});

const owner = env.authenticatedContext(OWNER).firestore();
const other = env.authenticatedContext(OTHER).firestore();
const voter = env.authenticatedContext(VOTER).firestore();
const store = (db) => doc(db, 'approvedApplications', STORE);
const vote = (db) => doc(db, 'approvedApplications', STORE, 'votes', VOTER);

const results = [];
const check = async (label, promise) => {
  try {
    await promise;
    results.push(['PASS', label]);
  } catch (error) {
    results.push(['FAIL', `${label} :: ${error.message.split('\n')[0]}`]);
  }
};

await check(
  'sahip kunye alanlarini guncelleyebilir (name/phone/address/category)',
  assertSucceeds(
    updateDoc(store(owner), {
      name: 'Kunefeci Saim Usta 2',
      phone: '0326 111 11 11',
      address: 'Yeni adres',
      category: { name: 'Kahvalti', value: 3 },
      updatedAt: new Date(),
    }),
  ),
);

await check(
  'sahip showcaseModules yazabilir',
  assertSucceeds(
    updateDoc(store(owner), {
      showcaseModules: [{ id: 'm1', type: 'campaign', title: 'Indirim', order: 0 }],
      updatedAt: new Date(),
    }),
  ),
);

await check(
  'sahip isApproved degistiremez',
  assertFails(updateDoc(store(owner), { isApproved: false })),
);

await check(
  'sahip ownerId devredemez',
  assertFails(updateDoc(store(owner), { ownerId: OTHER })),
);

await check(
  'baskasi mekani guncelleyemez',
  assertFails(updateDoc(store(other), { name: 'Ele gecirdim' })),
);

await check(
  'imzali kullanici visitCount +1 artirabilir',
  assertSucceeds(updateDoc(store(other), { visitCount: 11 })),
);

await check(
  'visitCount +5 atlatilamaz',
  assertFails(updateDoc(store(other), { visitCount: 99 })),
);

await check(
  'sahip yoruma merchantReply yazabilir',
  assertSucceeds(
    updateDoc(vote(owner), {
      merchantReply: 'Tesekkurler',
      merchantReplyAt: new Date(),
    }),
  ),
);

await check(
  'sahip yorumun puanini degistiremez',
  assertFails(updateDoc(vote(owner), { score: 1 })),
);

await check(
  'baskasi merchantReply yazamaz',
  assertFails(updateDoc(vote(other), { merchantReply: 'sahte' })),
);

await check(
  'vitrin herkese acik okunur',
  assertSucceeds(getDoc(store(voter))),
);

const COUPON = 'coupon_kunefe_20';
await env.withSecurityRulesDisabled(async (ctx) => {
  await setDoc(doc(ctx.firestore(), 'coupons', COUPON), {
    storeId: STORE,
    merchantUid: OWNER,
    ratio: 20,
    usageCount: 0,
  });
});

const redemption = (db, uid) =>
  doc(db, 'coupons', COUPON, 'redemptions', uid);

await check(
  'esnaf kullanicinin kupon hakkini olusturabilir',
  assertSucceeds(
    setDoc(redemption(owner, VOTER), {
      userUid: VOTER,
      merchantUid: OWNER,
      storeId: STORE,
      redeemedAt: new Date(),
    }),
  ),
);

await check(
  'ayni kullaniciya ikinci kez kullandirilamaz (hakki dolu)',
  assertFails(
    setDoc(redemption(owner, VOTER), {
      userUid: VOTER,
      merchantUid: OWNER,
      storeId: STORE,
      redeemedAt: new Date(),
    }),
  ),
);

await check(
  'esnaf var olan hakki okuyabilir',
  assertSucceeds(getDoc(redemption(owner, VOTER))),
);

await check(
  'esnaf henuz olusmamis hakki da okuyabilir',
  assertSucceeds(getDoc(redemption(owner, OTHER))),
);

await check(
  'baska bir esnaf hak tanimlayamaz',
  assertFails(
    setDoc(redemption(other, OTHER), {
      userUid: OTHER,
      merchantUid: OTHER,
      storeId: STORE,
      redeemedAt: new Date(),
    }),
  ),
);

await check(
  'esnaf kendi kuponunun usageCount alanini artirabilir',
  assertSucceeds(updateDoc(doc(owner, 'coupons', COUPON), { usageCount: 1 })),
);

await env.cleanup();

for (const [status, label] of results) {
  console.log(`${status === 'PASS' ? '  ✓' : '  ✗'} ${label}`);
}
const failed = results.filter(([status]) => status === 'FAIL').length;
console.log(`\n${results.length - failed}/${results.length} gecti`);
process.exit(failed === 0 ? 0 : 1);
