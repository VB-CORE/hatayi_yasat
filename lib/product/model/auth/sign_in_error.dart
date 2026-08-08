/// Why a sign-in attempt failed. Collapsing every failure into one message
/// hides the two cases users can actually act on — an email already bound to
/// another provider, and a dead connection — so they are kept apart here.
enum SignInError {
  /// The email already belongs to an account created with another provider.
  accountExistsWithDifferentCredential,

  /// The provider token was rejected: expired, malformed or nonce mismatch.
  invalidCredential,

  /// The provider is not enabled in the Firebase console.
  providerDisabled,

  /// The account was disabled server side.
  userDisabled,

  /// No usable connection while talking to Firebase or the provider.
  network,

  /// The platform cannot run this provider at all (missing capability, too
  /// old an OS).
  unsupported,

  /// Everything else; the code is still sent to Crashlytics.
  unknown,
}
