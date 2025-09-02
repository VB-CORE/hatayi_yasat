// home.js - Home screen page objects
output.home = {
  // Main containers
  splashView: "splashView",
  mainTabView: "mainTabView",
  homeView: "homeView",
  homeScrollView: "homeScrollView",
  homeSliverAppBar: "homeSliverAppBar",

  // Search and filter elements
  homeSearchFilterRow: "homeSearchFilterRow",
  homeSearchField: "homeSearchField",
  homeFilterButton: "homeFilterButton",

  // Categories
  homeCategoriesSection: "homeCategoriesSection",

  // Place cards
  placeCard: {
    hermes: ".*place_grid_card_Hermes.*",
    cardContainer: "place_grid_card",
  },

  // Navigation elements
  bottomNavigation: "main_bottom_navigation",
  tabBar: "main_tab_bar",

  // FAB elements
  floatingActionButton: "Floating Action Button",

  // Product elements
  productName: ".*Hermes.*",

  button: {
    phone: "placeDetailCallButton",
    road: "placeDetailFindThePlaceButton",
  },
};
