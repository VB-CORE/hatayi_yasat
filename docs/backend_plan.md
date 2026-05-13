# V2 Backend Plan — Hatayı Yaşat

**Status (2026-05-10)**: Client repositories ship with full Firestore + Storage wiring against the schemas below. Collections do not yet exist in the database; the first write from the client materialises them. This document tracks the schemas, indexes, and security-rule changes that need to land in the Firebase project before V2 goes to production.

The `life_shared` package will absorb these repositories in a follow-up. Until then they live under [lib/product/repository/](lib/product/repository/) with API surfaces designed to be lift-and-shift.

---

## 1. Authentication

**Current**: no FirebaseAuth flow. Repositories stamp `'guest'` on every write through [lib/product/repository/_auth_session.dart](lib/product/repository/_auth_session.dart).

**Plan**:
- Add `firebase_auth` to `pubspec.yaml` (already present indirectly through `firebase_core`).
- Wire Email + Google + Apple providers behind a unified sign-in flow.
- Replace the body of `currentUid` in `_auth_session.dart` with `FirebaseAuth.instance.currentUser?.uid ?? 'guest'`.
- On first successful sign-in, upsert `user_profiles/{uid}` via `UserProfileRepository.upsert(...)` with the provider's display name + a hash-derived `avatarColorHex`.

**Rules to add** (apply to every collection below):
```
allow read: if true;                               // public reads, V2 has no private content
allow create: if request.auth != null;             // require sign-in for writes
allow update, delete: if request.auth.uid == resource.data.authorUid
                       || request.auth.token.admin == true;
```

---

## 2. Collections

### `posts/{postId}`
Used by: Feed (Topluluk segment), Profile (Paylaşımlarım), Place Detail (Bahsedilenler).

| Field | Type | Notes |
|---|---|---|
| `authorUid` | string | currentUid; `'guest'` until auth lands |
| `authorName` | string | denormalised from `user_profiles` |
| `authorAvatarColor` | string | hex string |
| `cityId` | string | `'hatay'` \| `'mersin'` |
| `text` | string | ≤ 500 chars |
| `photos` | array<string> | Storage download URLs |
| `placeId`, `placeName`, `placeDistrict` | string? | optional place tag |
| `isMemory` | bool | true for memory-style posts |
| `year` | int? | populated when `isMemory == true` |
| `likeCount`, `commentCount` | int | maintained by transactions |
| `createdAt` | timestamp | `serverTimestamp` |
| `status` | string | `'pending'` \| `'approved'` \| `'rejected'` (V2 ships writes as `'approved'` until moderation Cloud Function lands) |

**Indexes** (composite):
- `(cityId asc, status asc, createdAt desc)` for the feed.
- `(authorUid asc, createdAt desc)` for profile.
- `(placeId asc, status asc, createdAt desc)` for place detail.

### `post_likes/{postId}_{uid}`
Presence document — `{ postId, uid, kind: 'like', createdAt }`. Created/deleted in a transaction with `posts/{postId}.likeCount`.

### `comments/{commentId}`
Stub schema — UI shows "Yorumlar çok yakında" for V2; collection is reserved for the next round.

| Field | Type |
|---|---|
| `postId` | string |
| `authorUid`, `authorName` | string |
| `text` | string |
| `createdAt` | timestamp |
| `likeCount` | int |

**Indexes**: `(postId asc, createdAt asc)`.

### `memories/{memoryId}`
Used by: Memories tab (Hatıralar), Profile (Hatıralarım), Favorites (Hatıralar).

Same shape as `posts` plus:
| Field | Type | Notes |
|---|---|---|
| `title` | string | required |
| `era` | string | e.g. "1990lar" |
| `neighborhood` | string | mahalle / ilçe |
| `loveCount` | int | tracks love presence in `memory_loves` |

### `memory_loves/{memoryId}_{uid}`
Presence document parallel to `post_likes`.

### `favorites/{uid}/{kind}/{id}`
Sub-collections under each user. `kind ∈ {'places', 'posts', 'memories'}`. Each doc just carries `addedAt`. Used by Favorites tab segments and the "saved" state on cards.

### `merchant_applications/{appId}`
Used by: Profile (merchant card status), Merchant Onboarding modal.

| Field | Type | Notes |
|---|---|---|
| `uid` | string | applicant |
| `placeName`, `placeCategory`, `description` | string | step 1 |
| `photos` | array<string> | up to 5; Storage URLs |
| `phone`, `address`, `hours` | string | step 2 |
| `location` | GeoPoint? | optional pin |
| `ownerName`, `taxNumber`, `registryNumber` | string | step 3 |
| `documents` | array<string> | uploaded ID/registry papers |
| `status` | string | `'submitted'` \| `'in_review'` \| `'approved'` \| `'rejected'` |
| `timeline` | array<{stage, at, note?}> | append-only audit trail |
| `createdAt` | timestamp | |

**Indexes**: `(uid asc, createdAt desc)` for "my applications".

**Approval workflow** (Cloud Function follow-up):
- Trigger on `status` flipping to `'approved'`: copy `documents`/`photos` from `pending/merchant/...` to `approved/merchant/...`, set `user_profiles/{uid}.role = 'merchant'`.

### `user_profiles/{uid}`
Used by: Profile, post/memory authoring, merchant flow, comment authoring.

| Field | Type |
|---|---|
| `handle` | string |
| `displayName` | string |
| `avatarColorHex` | string |
| `district` | string |
| `cityId` | string |
| `role` | `'guest'` \| `'user'` \| `'merchant'` \| `'admin'` |
| `createdAt`, `updatedAt` | timestamp |

### `reviews/{reviewId}`
Used by: Place Detail (Yorumlar tab), Review Composer sheet.

| Field | Type | Notes |
|---|---|---|
| `placeId` | string | indexed |
| `authorUid`, `authorName` | string | name blanked when `anonymous == true` |
| `anonymous` | bool | |
| `rating` | int | 1–5 |
| `text` | string | |
| `createdAt` | timestamp | |
| `status` | string | `'pending'` \| `'approved'` \| `'rejected'` |

**Indexes**: `(placeId asc, status asc, createdAt desc)`.

---

## 3. Cloud Storage

| Path | Owner | Lifecycle |
|---|---|---|
| `pending/posts/{uid}/{postId}/{i}.jpg` | post author | written by client; promoted to `approved/...` by moderation CF |
| `pending/memories/{uid}/{memoryId}/{i}.jpg` | memory author | same |
| `pending/merchant/{uid}/{appId}/photos/{i}.jpg` | applicant | promoted on approval |
| `pending/merchant/{uid}/{appId}/documents/{i}.jpg` | applicant | promoted on approval |
| `approved/posts/{postId}/{i}.jpg` | server | served on the public feed |

**Security rules** (sketch):
```
match /pending/{kind}/{uid}/{rest=**} {
  allow read: if true;
  allow write: if request.auth != null && request.auth.uid == uid;
}
match /approved/{rest=**} {
  allow read: if true;
  allow write: if false;   // only Cloud Functions write here
}
```

---

## 4. Cloud Functions (deferred follow-ups)

- **Post moderation**: nightly job + admin endpoint flipping `posts.status: pending → approved` once review is built.
- **Like fan-out**: maintain denormalised `likeCount` even under high concurrency (current client transaction is correct but slow at scale).
- **Merchant approval**: copy assets `pending → approved`, set `user_profiles/{uid}.role = 'merchant'`, push notification to the applicant.
- **Anti-abuse**: daily cap on `posts` + `memories` per uid; profanity filter on text fields.

---

## 5. FCM Topics

Existing topics: `toAll`, `forCampaign`, `news`, `advertise`, `toAllLinked`.

New topics to register:
- `post_in_<cityId>` — broadcast when a new approved post lands.
- `memory_in_<cityId>` — same for memories.
- `merchant_decision_<uid>` — direct to applicant when application status changes.

---

## 6. Pagination

V2 ships without infinite scroll. The repository methods accept a `limit` and the schemas are index-friendly so adding `startAfterDocument(...)` later is mechanical.

---

## 7. Existing Permissive Rules (pre-V2 — flag for hardening)

- `unApprovedCampaigns`: `allow write: if true` — should require admin claim.
- `categories/{document}`: `allow write` (no condition) — admin-only.
- `pending/` Storage paths: same — currently match-all.

These predate V2 and are out of this round's scope but should be tightened in the same hardening pass that lands the auth-aware rules above.

---

## 8. Migration to `life_shared`

When the user moves the V2 repositories into the shared package:

1. Move every file under [lib/product/repository/](lib/product/repository/) to `life_shared/lib/src/feature/social/`.
2. Add the new collection names to `CollectionPaths` enum at `life_shared/lib/src/feature/firebase/enum/collection_paths.dart`. Replace direct `_firestore.collection('posts')` calls with `path.collection` once the typed converter pattern is wired.
3. Replace the local model classes with shared ones; delete the local copies.
4. Re-export providers from `life_shared` and update `import` paths in the client.

The repositories above are intentionally narrow (one class per entity, no shared base) so the lift is mechanical and reviewable.
