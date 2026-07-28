import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_panel_tab.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_dashboard_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_reviews_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_showcase_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_store_edit_sub_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

final class MerchantPanelView extends ConsumerStatefulWidget {
  const MerchantPanelView({super.key});

  @override
  ConsumerState<MerchantPanelView> createState() => _MerchantPanelViewState();
}

final class _MerchantPanelViewState extends ConsumerState<MerchantPanelView> {
  MerchantPanelTab _tab = MerchantPanelTab.dashboard;

  void _changeTab(MerchantPanelTab tab) => setState(() => _tab = tab);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantPanelViewModelProvider);

    if (state.isUnauthorized) {
      return Scaffold(
        appBar: PageAppBar(pageTitle: LocaleKeys.merchantPanel_title),
        body: GeneralNotFoundWidget(
          title: LocaleKeys.merchantPanel_unauthorizedTitle.tr(),
        ),
      );
    }

    final store = state.store;
    if (state.isError || store == null) {
      return Scaffold(
        appBar: PageAppBar(pageTitle: LocaleKeys.merchantPanel_title),
        body: state.isFetching
            ? const PlaceShimmerList()
            : GeneralNotFoundWidget(
                title: LocaleKeys.message_somethingWentWrong.tr(),
                onRefresh: () => unawaited(
                  ref.read(merchantPanelViewModelProvider.notifier).refresh(),
                ),
              ),
      );
    }

    return Scaffold(
      appBar: PageAppBar(pageTitle: LocaleKeys.merchantPanel_title),
      bottomNavigationBar: _MerchantPanelNavigationBar(
        tab: _tab,
        pendingReplyCount: state.pendingReplyCount,
        onChanged: _changeTab,
      ),
      body: IndexedStack(
        index: _tab.index,
        children: [
          MerchantDashboardSubView(state: state, onNavigate: _changeTab),
          MerchantReviewsSubView(storeId: store.documentId),
          MerchantShowcaseSubView(storeId: store.documentId),
          MerchantStoreEditSubView(store: store),
        ],
      ),
    );
  }
}

final class _MerchantPanelNavigationBar extends StatelessWidget {
  const _MerchantPanelNavigationBar({
    required this.tab,
    required this.pendingReplyCount,
    required this.onChanged,
  });

  final MerchantPanelTab tab;
  final int pendingReplyCount;
  final ValueChanged<MerchantPanelTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: tab.index,
      backgroundColor: AppColors.surface,
      onDestinationSelected: (index) =>
          onChanged(MerchantPanelTab.values[index]),
      destinations: [
        for (final item in MerchantPanelTab.values)
          NavigationDestination(
            icon: item == MerchantPanelTab.reviews && pendingReplyCount > 0
                ? Badge.count(count: pendingReplyCount, child: Icon(item.icon))
                : Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label.tr(),
          ),
      ],
    );
  }
}
