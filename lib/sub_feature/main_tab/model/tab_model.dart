import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lifeclient/features/main/history/history_view.dart';
import 'package:lifeclient/features/main/home/view/home_view.dart';
import 'package:lifeclient/features/main/news_jobs/view/news_jobs_view.dart';
import 'package:lifeclient/features/main/profile/view/profile_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/general/semantics/general_semantic_keys.dart';
import 'package:lifeclient/sub_feature/main_tab/widget/profile_tab_avatar.dart';

final class TabModel extends Equatable {
  const TabModel({
    required this.page,
    required this.icon,
    required this.title,
    required this.semanticKey,
    this.showAppBar = true,
  });

  @override
  List<Object?> get props => [page, icon, title, semanticKey, showAppBar];

  final Widget page;
  final Widget icon;
  final String title;
  final GeneralSemanticKeys semanticKey;
  final bool showAppBar;
}

final class TabModels {
  TabModels.create() {
    _tabItems = [
      const TabModel(
        page: HomeView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedStore01),
        title: LocaleKeys.navigationTabs_places,
        semanticKey: GeneralSemanticKeys.homeTab,
      ),
      const TabModel(
        page: NewsEventJobsView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
        title: LocaleKeys.navigationTabs_feed,
        semanticKey: GeneralSemanticKeys.communityTab,
      ),
      const TabModel(
        page: HistoryView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedCompass01),
        title: LocaleKeys.navigationTabs_explore,
        semanticKey: GeneralSemanticKeys.memoriesTab,
      ),
      const TabModel(
        page: ProfileView(),
        icon: ProfileTabAvatar(),
        title: LocaleKeys.navigationTabs_profile,
        semanticKey: GeneralSemanticKeys.favoriteTab,
        showAppBar: false,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
