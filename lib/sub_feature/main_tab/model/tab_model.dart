import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/main/feed/view/feed_view.dart';
import 'package:lifeclient/features/main/home/view/home_view.dart';
import 'package:lifeclient/features/profile/view/profile_view.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';

final class TabModel extends Equatable {
  const TabModel({
    required this.page,
    required this.icon,
    required this.title,
    required this.semanticKey,
  });

  @override
  List<Object?> get props => [page, icon, title, semanticKey];

  final Widget page;
  final IconData icon;
  final String title;
  final GeneralSemanticKeys semanticKey;
}

final class TabModels {
  TabModels.create() {
    _tabItems = const [
      TabModel(
        page: FeedView(),
        icon: Icons.home_rounded,
        title: LocaleKeys.navigationTabs_feed,
        semanticKey: GeneralSemanticKeys.communityTab,
      ),
      TabModel(
        page: HomeView(),
        icon: Icons.storefront_rounded,
        title: LocaleKeys.navigationTabs_places,
        semanticKey: GeneralSemanticKeys.homeTab,
      ),
      TabModel(
        page: FavoriteView(),
        icon: Icons.favorite_rounded,
        title: LocaleKeys.navigationTabs_favorite,
        semanticKey: GeneralSemanticKeys.favoriteTab,
      ),
      TabModel(
        page: ProfileView(),
        icon: Icons.person_rounded,
        title: LocaleKeys.navigationTabs_profile,
        semanticKey: GeneralSemanticKeys.memoriesTab,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
