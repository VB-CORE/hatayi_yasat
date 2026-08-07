import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_panel_tab.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_review_filter.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_view_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_reviews_view_model.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_dashboard_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_reviews_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_showcase_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/sub_view/merchant_store_edit_sub_view.dart';
import 'package:lifeclient/features/merchant_panel/view/widget/merchant_panel_header.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

part 'widget/merchant_panel_navigation_bar.dart';
part 'widget/merchant_panel_pinned_header.dart';
part 'widget/merchant_review_filter_bar.dart';

final class MerchantPanelView extends ConsumerStatefulWidget {
  const MerchantPanelView({super.key});

  @override
  ConsumerState<MerchantPanelView> createState() => _MerchantPanelViewState();
}

final class _MerchantPanelViewState extends ConsumerState<MerchantPanelView> {
  MerchantPanelViewModel get _viewModel =>
      ref.read(merchantPanelViewModelProvider.notifier);

  void _refresh() => unawaited(_viewModel.refresh());

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantPanelViewModelProvider);

    if (state.isUnauthorized) {
      return const _MerchantPanelMessageBody(
        titleKey: LocaleKeys.merchantPanel_unauthorizedTitle,
      );
    }

    final store = state.store;

    if (state.isError || store == null) {
      return _MerchantPanelMessageBody(
        titleKey: LocaleKeys.message_somethingWentWrong,
        isLoading: state.isFetching,
        onRefresh: _refresh,
      );
    }

    return DefaultTabController(
      length: MerchantPanelTab.values.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.bg,
        appBar: AppBar(backgroundColor: Colors.transparent),
        bottomNavigationBar: MerchantPanelNavigationBar(
          hasPendingReply: state.hasPendingReply,
        ),
        body: Column(
          children: [
            MerchantPanelHeader(store: store),
            MerchantPanelPinnedHeader(storeId: store.documentId),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MerchantDashboardSubView(state: state),
                  MerchantReviewsSubView(storeId: store.documentId),
                  MerchantShowcaseSubView(storeId: store.documentId),
                  MerchantStoreEditSubView(store: store),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _MerchantPanelMessageBody extends StatelessWidget {
  const _MerchantPanelMessageBody({
    required this.titleKey,
    this.isLoading = false,
    this.onRefresh,
  });

  final String titleKey;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        pageTitle: LocaleKeys.merchantPanel_title,
      ),
      body: isLoading
          ? const PlaceShimmerList()
          : GeneralNotFoundWidget(title: titleKey.tr(), onRefresh: onRefresh),
    );
  }
}
