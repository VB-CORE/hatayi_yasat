enum AuthProvider { google, apple }

extension AuthProviderX on AuthProvider {
  String get displayName => switch (this) {
    AuthProvider.google => 'Google',
    AuthProvider.apple => 'Apple',
  };
}
