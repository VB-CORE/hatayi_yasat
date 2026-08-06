/// User properties mirrored to Analytics and Crashlytics.
///
/// GA4 allows 25 custom properties per project, 24 characters per name and
/// 36 per value. Every value here is categorical on purpose — no PII reaches
/// Analytics, only the uid via `setUserId`.
enum AnalyticsUserProperty {
  authStatus('auth_status'),
  userRole('user_role'),
  isMerchant('is_merchant'),
  appTheme('app_theme');

  const AnalyticsUserProperty(this.key);

  final String key;
}

/// Coarse auth segmentation: everything else about the account stays out of
/// Analytics.
enum AnalyticsAuthStatus {
  guest('guest'),
  loggedIn('logged_in'),
  banned('banned');

  const AnalyticsAuthStatus(this.key);

  final String key;
}
