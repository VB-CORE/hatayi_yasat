/// Session helper used by repositories until FirebaseAuth lands.
///
/// All write paths in the V2 stack call [currentUid] to stamp a
/// `authorUid` / `uid` on documents. There is no auth flow yet, so we
/// hand back a `'guest'` placeholder that Firestore rules currently
/// allow. When auth is wired (see `docs/backend_plan.md`), the body of
/// this method becomes a single-line read of
/// `FirebaseAuth.instance.currentUser?.uid` with a guest fallback.
String get currentUid => 'guest';

/// Display name placeholder; real value comes from `user_profiles/{uid}`.
String get currentDisplayName => 'Misafir';

/// Avatar colour placeholder; per-user value will be persisted on the
/// user profile once auth ships.
String get currentAvatarColor => 'navy';
