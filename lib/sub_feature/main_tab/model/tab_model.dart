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
    required this.analyticsName,
    this.showAppBar = true,
    this.showQr = false,
  });

  @override
  List<Object?> get props => [
    page,
    icon,
    title,
    semanticKey,
    analyticsName,
    showAppBar,
    showQr,
  ];

  final Widget page;
  final Widget icon;
  final String title;
  final GeneralSemanticKeys semanticKey;

  final String analyticsName;

  final bool showAppBar;
  final bool showQr;
}

final class TabModels {
  TabModels.create() {
    _tabItems = [
      const TabModel(
        page: HomeView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedStore01),
        title: LocaleKeys.navigationTabs_places,
        semanticKey: GeneralSemanticKeys.homeTab,
        analyticsName: 'home',
      ),
      const TabModel(
        page: NewsEventJobsView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
        title: LocaleKeys.navigationTabs_feed,
        semanticKey: GeneralSemanticKeys.communityTab,
        analyticsName: 'feed',
      ),
      const TabModel(
        page: HistoryView(),
        icon: HugeIcon(icon: HugeIcons.strokeRoundedCompass01),
        title: LocaleKeys.navigationTabs_explore,
        semanticKey: GeneralSemanticKeys.memoriesTab,
        analyticsName: 'explore',
      ),
      const TabModel(
        page: ProfileView(),
        icon: ProfileTabAvatar(),
        title: LocaleKeys.navigationTabs_profile,
        semanticKey: GeneralSemanticKeys.favoriteTab,
        analyticsName: 'profile',
        showAppBar: false,
        showQr: true,
      ),
    ];
  }
  late final List<TabModel> _tabItems;

  List<TabModel> get tabItems => _tabItems;
}
