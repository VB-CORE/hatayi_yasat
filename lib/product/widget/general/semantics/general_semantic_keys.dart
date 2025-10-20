enum GeneralSemanticKeys {
  onboardButton('onboardButton'),
  mainTabView('mainTabView'),
  mainTabBottomNavigation('mainTabBottomNavigation'),
  splashView('splashView'),
  whatsNewSheet('whatsNewSheet'),

  /// home view
  homeView('homeView'),
  homeScrollView('homeScrollView'),
  homeSliverAppBar('homeSliverAppBar'),
  homeSearchFilterRow('homeSearchFilterRow'),
  homeSearchField('homeSearchField'),
  homeFilterButton('homeFilterButton'),
  homeCategoriesSection('homeCategoriesSection'),

  /// home detail
  placeDetailCallButton('placeDetailCallButton'),
  placeDetailFindThePlaceButton('placeDetailFindThePlaceButton'),

  // bottom bar
  homeTab('homeTab'),
  communityTab('communityTab'),
  memoriesTab('memoriesTab'),
  favoriteTab('favoriteTab');

  final String key;

  const GeneralSemanticKeys(this.key);
}
