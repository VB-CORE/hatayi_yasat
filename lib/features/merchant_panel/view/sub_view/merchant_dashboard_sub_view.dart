import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_panel_tab.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/pill/status_pill.dart';

part 'widget/merchant_dashboard_header.dart';
part 'widget/merchant_manage_tile.dart';
part 'widget/merchant_stat_card.dart';

final class MerchantDashboardSubView extends StatelessWidget {
  const MerchantDashboardSubView({
    required this.state,
    required this.onNavigate,
    super.key,
  });

  final MerchantPanelState state;
  final ValueChanged<MerchantPanelTab> onNavigate;

  @override
  Widget build(BuildContext context) {
    final store = state.store;
    if (store == null) return const SizedBox.shrink();

    return ListView(
      padding: const PagePadding.generalAllLow(),
      children: [
        _MerchantDashboardHeader(
          store: store,
          averageScore: state.averageScore,
        ),
        const EmptyBox.middleHeight(),
        Text(
          LocaleKeys.merchantPanel_dashboard_summaryTitle.tr().toUpperCase(),
          style: AppText.eyebrow,
        ),
        const EmptyBox.smallHeight(),
        Row(
          spacing: AppSpacing.xs,
          children: [
            Expanded(
              child: _MerchantStatCard(
                icon: AppIcons.visibility,
                value: '${state.visitCount}',
                label: LocaleKeys.merchantPanel_dashboard_visitCount.tr(),
              ),
            ),
            Expanded(
              child: _MerchantStatCard(
                icon: AppIcons.rate,
                value: state.averageScore.toStringAsFixed(1),
                label: LocaleKeys.merchantPanel_dashboard_averageScore.tr(),
              ),
            ),
            Expanded(
              child: _MerchantStatCard(
                icon: AppIcons.comment,
                value: '${state.comments.length}',
                label: LocaleKeys.merchantPanel_dashboard_reviewCount.tr(),
              ),
            ),
          ],
        ),
        const EmptyBox.middleHeight(),
        Text(
          LocaleKeys.merchantPanel_dashboard_manageTitle.tr().toUpperCase(),
          style: AppText.eyebrow,
        ),
        const EmptyBox.smallHeight(),
        _MerchantManageTile(
          icon: AppIcons.comment,
          badgeCount: state.pendingReplyCount,
          title: LocaleKeys.merchantPanel_dashboard_manageReviews.tr(),
          subtitle: state.pendingReplyCount == 0
              ? LocaleKeys.merchantPanel_dashboard_manageReviewsEmptySubtitle
                    .tr()
              : LocaleKeys.merchantPanel_dashboard_manageReviewsSubtitle.tr(
                  args: ['${state.pendingReplyCount}'],
                ),
          onTap: () => onNavigate(MerchantPanelTab.reviews),
        ),
        _MerchantManageTile(
          icon: AppIcons.announcement,
          title: LocaleKeys.merchantPanel_dashboard_manageShowcase.tr(),
          subtitle: LocaleKeys.merchantPanel_dashboard_manageShowcaseSubtitle
              .tr(),
          onTap: () => onNavigate(MerchantPanelTab.showcase),
        ),
        _MerchantManageTile(
          icon: AppIcons.storeFilled,
          title: LocaleKeys.merchantPanel_dashboard_manageStore.tr(),
          subtitle: LocaleKeys.merchantPanel_dashboard_manageStoreSubtitle.tr(),
          onTap: () => onNavigate(MerchantPanelTab.store),
        ),
        _MerchantManageTile(
          icon: AppIcons.discount,
          title: LocaleKeys.merchantPanel_dashboard_manageCoupons.tr(),
          subtitle: LocaleKeys.merchantPanel_dashboard_manageCouponsSubtitle
              .tr(),
          onTap: () => const MonetizationRoute().go(context),
        ),
      ],
    );
  }
}
