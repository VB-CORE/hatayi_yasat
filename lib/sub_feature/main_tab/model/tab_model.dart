import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/main/history/history_view.dart';
import 'package:lifeclient/features/main/home/view/home_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/sub_feature/favorite/view/favorite_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
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
  final Widget icon;
  final String title;
  final GeneralSemanticKeys semanticKey;
}

final class TabModels {
  TabModels.create() {
    _tabItems = [
      const TabModel(
        page: HomeView(),
        icon: Icon(AppIcons.home),
        title: LocaleKeys.navigationTabs_home,
        semanticKey: GeneralSemanticKeys.homeTab,
      ),
      const TabModel(
        page: NewsEventJobsView(),
        icon: Icon(AppIcons.community),
        title: LocaleKeys.navigationTabs_community,
        semanticKey: GeneralSemanticKeys.communityTab,
      ),
      const TabModel(
        page: HistoryView(),
        icon: Icon(AppIcons.tree),
        title: LocaleKeys.navigationTabs_memories,
        semanticKey: GeneralSemanticKeys.memoriesTab,
      ),
      const TabModel(
        page: FavoriteView(),
        icon: Icon(AppIcons.favorite),
        title: LocaleKeys.navigationTabs_favorite,
        semanticKey: GeneralSemanticKeys.favoriteTab,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
