/// Analytics event registry.
///
/// GA4 constraints every entry has to satisfy: snake_case, 40 characters max,
/// and none of the reserved `firebase_` / `google_` / `ga_` prefixes.
/// Names marked as recommended map onto GA4's built-in reports.
enum AnalyticsEvent {
  /// GA4 recommended event.
  login('login'),

  /// GA4 recommended event.
  signUp('sign_up'),
  logout('logout'),

  /// GA4 recommended event.
  search('search'),
  filterApply('filter_apply'),

  /// GA4 recommended event.
  selectContent('select_content'),

  viewPlaceDetail('view_place_detail'),
  placeCallTap('place_call_tap'),
  placeDirectionsTap('place_directions_tap'),
  ratePlace('rate_place'),

  viewCoupon('view_coupon'),
  couponRedeem('coupon_redeem'),
  couponRedeemFailed('coupon_redeem_failed'),

  createGroup('create_group'),
  createPost('create_post'),
  createDiscussion('create_discussion'),
  postLikeToggle('post_like_toggle'),

  formStart('form_start'),
  formSubmit('form_submit'),
  formError('form_error'),

  notificationOpen('notification_open'),
  merchantApplicationSubmit('merchant_application_submit');

  const AnalyticsEvent(this.key);

  final String key;
}

/// Parameter keys used with [AnalyticsEvent]. GA4 allows 25 parameters per
/// event, 40 characters per name and 100 per value.
enum AnalyticsParameter {
  method('method'),

  /// GA4 recommended parameter, powers the built-in search report.
  searchTerm('search_term'),
  contentType('content_type'),
  itemId('item_id'),
  categoryCount('category_count'),
  townCount('town_count'),
  placeId('place_id'),
  category('category'),
  score('score'),
  isLiked('is_liked'),
  couponId('coupon_id'),
  storeId('store_id'),
  groupId('group_id'),
  discussionId('discussion_id'),
  postId('post_id'),
  formType('form_type'),
  notificationType('notification_type'),
  reason('reason');

  const AnalyticsParameter(this.key);

  final String key;
}

/// Values for [AnalyticsParameter.formType]; keeps the four request forms
/// comparable in a single GA4 report instead of four ad-hoc strings.
enum AnalyticsFormType {
  placeRequest('place_request'),
  projectRequest('project_request'),
  scholarshipRequest('scholarship_request'),
  merchantApplication('merchant_application');

  const AnalyticsFormType(this.key);

  final String key;
}
