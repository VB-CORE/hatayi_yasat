#!/usr/bin/env node
// Esnaf paneli test verisi. Emulator ayaktayken calistirilir:
//
//   ./start-emulator.sh
//   node seed_merchant.mjs
//
// Hesaplar (sifre hepsinde: 123456)
//   merchant@hatay.test  -> onayli esnaf, "Kunefeci Saim Usta" sahibi
//   other@hatay.test     -> onayli esnaf, baska mekan (ownerId guard negatif testi)
//   admin@hatay.test     -> adminList/config icinde
//   ayse@hatay.test / mehmet@hatay.test / zeynep@hatay.test -> yorum birakan kullanicilar

const PROJECT_ID = process.env.FIREBASE_PROJECT_ID ?? 'savehatay';
const AUTH_HOST = process.env.AUTH_EMULATOR_HOST ?? '127.0.0.1:3000';
const FIRESTORE_HOST = process.env.FIRESTORE_EMULATOR_HOST ?? '127.0.0.1:3004';

const AUTH_BASE = `http://${AUTH_HOST}/identitytoolkit.googleapis.com/v1/projects/${PROJECT_ID}`;
const DOCS_BASE = `http://${FIRESTORE_HOST}/v1/projects/${PROJECT_ID}/databases/(default)/documents`;
const OWNER = { Authorization: 'Bearer owner', 'Content-Type': 'application/json' };

const STORE_ID = 'store_kunefeci_saim';
const OTHER_STORE_ID = 'store_antakya_kahvalti';
const CITY_ID = 'city_hatay';
const PASSWORD = '123456';

const IMAGES = [
  'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?w=1200',
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1200',
  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200',
];

const USERS = [
  { uid: 'uid_merchant', email: 'merchant@hatay.test', displayName: 'Saim Usta', permissions: [1, 2] },
  { uid: 'uid_other_merchant', email: 'other@hatay.test', displayName: 'Antakya Kahvalti', permissions: [] },
  { uid: 'uid_admin', email: 'admin@hatay.test', displayName: 'Hatay Admin', permissions: [1, 2] },
  { uid: 'uid_ayse', email: 'ayse@hatay.test', displayName: 'Ayse Akdeniz', permissions: [] },
  { uid: 'uid_mehmet', email: 'mehmet@hatay.test', displayName: 'Mehmet Dogan', permissions: [] },
  { uid: 'uid_zeynep', email: 'zeynep@hatay.test', displayName: 'Zeynep Kaya', permissions: [] },
];

const daysAgo = (days) => new Date(Date.now() - days * 86_400_000);
const daysAhead = (days) => new Date(Date.now() + days * 86_400_000);

function toValue(value) {
  if (value === null || value === undefined) return { nullValue: null };
  if (value instanceof Date) return { timestampValue: value.toISOString() };
  if (Array.isArray(value)) {
    return { arrayValue: { values: value.map(toValue) } };
  }
  if (typeof value === 'object') {
    if ('latitude' in value && 'longitude' in value) {
      return { geoPointValue: { latitude: value.latitude, longitude: value.longitude } };
    }
    return { mapValue: { fields: toFields(value) } };
  }
  if (typeof value === 'boolean') return { booleanValue: value };
  if (typeof value === 'number') {
    return Number.isInteger(value) ? { integerValue: `${value}` } : { doubleValue: value };
  }
  return { stringValue: `${value}` };
}

function toFields(data) {
  return Object.fromEntries(
    Object.entries(data)
      .filter(([, value]) => value !== undefined)
      .map(([key, value]) => [key, toValue(value)]),
  );
}

async function request(url, options) {
  const response = await fetch(url, options);
  if (!response.ok) {
    throw new Error(`${options.method} ${url} -> ${response.status} ${await response.text()}`);
  }
  return response.json();
}

async function putDocument(path, data) {
  await request(`${DOCS_BASE}/${path}`, {
    method: 'PATCH',
    headers: OWNER,
    body: JSON.stringify({ fields: toFields(data) }),
  });
  console.log(`  doc  ${path}`);
}

async function putUser({ uid, email, displayName, permissions }) {
  await request(`${AUTH_BASE}/accounts`, {
    method: 'POST',
    headers: OWNER,
    body: JSON.stringify({
      localId: uid,
      email,
      password: PASSWORD,
      displayName,
      emailVerified: true,
    }),
  }).catch(async (error) => {
    if (!`${error}`.includes('EMAIL_EXISTS') && !`${error}`.includes('DUPLICATE_LOCAL_ID')) throw error;
    await request(`${AUTH_BASE}/accounts:update`, {
      method: 'POST',
      headers: OWNER,
      body: JSON.stringify({ localId: uid, password: PASSWORD, displayName, emailVerified: true }),
    });
  });

  if (permissions.length > 0) {
    await request(`${AUTH_BASE}/accounts:update`, {
      method: 'POST',
      headers: OWNER,
      body: JSON.stringify({
        localId: uid,
        customAttributes: JSON.stringify({ permissions }),
      }),
    });
  }
  console.log(`  auth ${email} (${uid})`);
}

const category = { name: 'Tatlici', value: 12 };

function storeDocument({ ownerId, name, description, showcaseModules }) {
  return {
    name,
    owner: name,
    description,
    address: 'Ulus Mah. Kurtulus Cad. No:12, Antakya',
    phone: '0326 214 00 12',
    images: IMAGES,
    townCode: 31001,
    cityId: CITY_ID,
    ownerId,
    isApproved: true,
    isCommentEnabled: true,
    openTime: '08:00',
    closeTime: '22:00',
    visitCount: 1248,
    deviceID: 'emulator-seed',
    category,
    latLong: { latitude: 36.2021, longitude: 36.1601 },
    showcaseModules,
    createdAt: daysAgo(240),
    updatedAt: daysAgo(2),
  };
}

const showcaseModules = [
  {
    id: 'module_festival',
    type: 'campaign',
    title: 'Kunefe Festivali Indirimi',
    description: 'Festival haftasi boyunca kunefede %20 indirim. Hafta sonu canli kunefe yapimi gosterisi.',
    imageUrl: IMAGES[0],
    startAt: daysAgo(3),
    endAt: daysAhead(11),
    isActive: true,
    order: 0,
  },
  {
    id: 'module_working_hours',
    type: 'announcement',
    title: 'Bayramda calisma saatleri',
    description: 'Bayramin birinci gunu 12:00 - 20:00 arasi hizmet veriyoruz.',
    imageUrl: null,
    startAt: daysAgo(1),
    endAt: daysAhead(20),
    isActive: true,
    order: 1,
  },
  {
    id: 'module_workshop',
    type: 'event',
    title: 'Kunefe atolyesi',
    description: 'Cumartesi 15:00 - kayit ile 10 kisilik atolye.',
    imageUrl: IMAGES[2],
    startAt: daysAhead(4),
    endAt: daysAhead(4),
    isActive: false,
    order: 2,
  },
];

const votes = [
  {
    voterUid: 'uid_ayse',
    userName: 'Ayse Akdeniz',
    score: 5,
    comment: '60 yillik firin hala ayni tat. Sabah erken giderseniz Saim Usta`nin elinden hala kendisi yapiyor.',
    createdAt: daysAgo(3),
    updatedAt: daysAgo(3),
  },
  {
    voterUid: 'uid_mehmet',
    userName: 'Mehmet Dogan',
    score: 4,
    comment: 'Kunefe muhtesem ama servis biraz yavasti. Fiyatlar son zamanlarda artti, yine de tek tercihim burasi.',
    createdAt: daysAgo(9),
    updatedAt: daysAgo(9),
  },
  {
    voterUid: 'uid_zeynep',
    userName: 'Zeynep Kaya',
    score: 3,
    comment: 'Lezzetli ama 4 kisilik aile icin pahali. Aksam saatleri cok kalabalik, masa beklemek zor.',
    createdAt: daysAgo(21),
    updatedAt: daysAgo(1),
    merchantReply: 'Geri bildiriminiz icin tesekkurler, aksam saatleri icin rezervasyon hattimizi devreye aldik.',
    merchantReplyAt: daysAgo(1),
  },
];

async function seed() {
  console.log(`Auth      : ${AUTH_HOST}`);
  console.log(`Firestore : ${FIRESTORE_HOST}`);
  console.log(`Project   : ${PROJECT_ID}\n`);

  console.log('Hesaplar');
  if (process.env.SKIP_AUTH === '1') {
    console.log('  atlandi (SKIP_AUTH=1)');
  } else {
    for (const user of USERS) await putUser(user);
  }

  console.log('\nKoleksiyonlar');
  await putDocument('adminList/config', { emails: ['admin@hatay.test'] });

  await putDocument(`regionalCities/${CITY_ID}`, {
    name: 'Hatay',
    initial: true,
    description: 'Hatay',
    location: { latitude: 36.2021, longitude: 36.1601 },
  });

  await putDocument('regionalTowns/town_hatay', {
    cityId: CITY_ID,
    towns: [
      { code: 31001, name: 'Antakya' },
      { code: 31002, name: 'Defne' },
      { code: 31003, name: 'Iskenderun' },
    ],
  });

  await putDocument('categories/category_tatlici', category);
  await putDocument('categories/category_kahvalti', { name: 'Kahvalti', value: 3 });

  await putDocument(
    `approvedApplications/${STORE_ID}`,
    storeDocument({
      ownerId: 'uid_merchant',
      name: 'Kunefeci Saim Usta',
      description: '60 yillik firin, Antakya`nin en eski kunefecisi. Hatay peyniri ve kaymakla.',
      showcaseModules,
    }),
  );

  await putDocument(
    `approvedApplications/${OTHER_STORE_ID}`,
    storeDocument({
      ownerId: 'uid_other_merchant',
      name: 'Antakya Kahvalti Evi',
      description: 'Serpme kahvalti ve zahter.',
      showcaseModules: [],
    }),
  );

  for (const vote of votes) {
    await putDocument(`approvedApplications/${STORE_ID}/votes/${vote.voterUid}`, vote);
  }

  const application = {
    id: STORE_ID,
    status: 2,
    ownershipDocumentUrl: 'https://example.com/tapu.pdf',
    createdAt: daysAgo(240),
    updatedAt: daysAgo(200),
  };

  for (const user of USERS) {
    const isMerchant = user.uid === 'uid_merchant';
    const isOtherMerchant = user.uid === 'uid_other_merchant';
    await putDocument(`users/${user.uid}`, {
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      roleType: user.uid === 'uid_admin' ? 1 : 2,
      permissions: user.permissions,
      rates: isMerchant || isOtherMerchant ? [] : [STORE_ID],
      application: isMerchant
        ? application
        : isOtherMerchant
          ? { ...application, id: OTHER_STORE_ID }
          : undefined,
      updatedAt: daysAgo(1),
    });
  }

  await putDocument('coupons/coupon_kunefe_20', {
    storeId: STORE_ID,
    merchantUid: 'uid_merchant',
    desc: 'Kunefe siparisinde %20 indirim',
    ratio: 20,
    usageCount: 4,
    usageLimit: 100,
    expiresAt: daysAhead(14),
    createdAt: daysAgo(5),
    updatedAt: daysAgo(5),
  });

  // Pasif sekmesinin de dolu olmasi icin suresi gecmis kupon.
  await putDocument('coupons/coupon_kis_10', {
    storeId: STORE_ID,
    merchantUid: 'uid_merchant',
    desc: 'Kis kampanyasi %10 indirim',
    ratio: 10,
    usageCount: 12,
    usageLimit: 12,
    expiresAt: daysAgo(3),
    createdAt: daysAgo(60),
    updatedAt: daysAgo(60),
  });

  // Ayse bu kupondan yararlanmis: QR'i tekrar okutuldugunda "hakki dolu".
  await putDocument('coupons/coupon_kunefe_20/redemptions/uid_ayse', {
    userUid: 'uid_ayse',
    merchantUid: 'uid_merchant',
    storeId: STORE_ID,
    redeemedAt: daysAgo(2),
  });

  console.log(`\nHazir. Esnaf girisi: merchant@hatay.test / ${PASSWORD}  (store: ${STORE_ID})`);
}

seed().catch((error) => {
  console.error(`\nSeed basarisiz: ${error.message}`);
  process.exit(1);
});
