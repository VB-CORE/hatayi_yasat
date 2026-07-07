enum AuthProvider {
  google,
  apple;

  static const String argKey = 'provider';
}

extension AuthProviderX on AuthProvider {
  String get displayName => switch (this) {
    AuthProvider.google => 'Google',
    AuthProvider.apple => 'Apple',
  };
}
