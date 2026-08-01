import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_panel_tab.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/menu/content_menu.dart';

part 'widget/merchant_stat_card.dart';

final class MerchantDashboardSubView extends StatelessWidget {
  const MerchantDashboardSubView({required this.state, super.key});

  final MerchantPanelState state;

  void _goToTab(BuildContext context, MerchantPanelTab tab) =>
      DefaultTabController.of(context).animateTo(tab.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.horizontalNormalSymmetric() +
          const PagePadding.vertical12Symmetric(),
      child: Column(
        crossAxisAlignment: .start,
        children: [
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
                  value: state.store?.averageRatingLabel ?? '0',
                  label: LocaleKeys.merchantPanel_dashboard_averageScore.tr(),
                ),
              ),
              Expanded(
                child: _MerchantStatCard(
                  icon: AppIcons.comment,
                  value: '${state.reviewCount}',
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
          ContentMenu(
            iconColor: context.appColors.navy400,
            iconBackgroundColor: context.appColors.navy50,
            items: [
              ContentMenuItem(
                icon: AppIcons.commentFilled,
                showBadge: state.hasPendingReply,
                label: LocaleKeys.merchantPanel_dashboard_manageReviews.tr(),
                subtitle: state.hasPendingReply
                    ? LocaleKeys.merchantPanel_dashboard_manageReviewsSubtitle
                          .tr()
                    : LocaleKeys
                          .merchantPanel_dashboard_manageReviewsEmptySubtitle
                          .tr(),
                onTap: () => _goToTab(context, MerchantPanelTab.reviews),
              ),
              ContentMenuItem(
                icon: AppIcons.announcement,
                label: LocaleKeys.merchantPanel_dashboard_manageShowcase.tr(),
                subtitle: LocaleKeys
                    .merchantPanel_dashboard_manageShowcaseSubtitle
                    .tr(),
                onTap: () => _goToTab(context, MerchantPanelTab.showcase),
              ),
              ContentMenuItem(
                icon: AppIcons.storeFilled,
                label: LocaleKeys.merchantPanel_dashboard_manageStore.tr(),
                subtitle: LocaleKeys.merchantPanel_dashboard_manageStoreSubtitle
                    .tr(),
                onTap: () => _goToTab(context, MerchantPanelTab.store),
              ),
              ContentMenuItem(
                icon: AppIcons.discount,
                label: LocaleKeys.merchantPanel_dashboard_manageCoupons.tr(),
                subtitle: LocaleKeys
                    .merchantPanel_dashboard_manageCouponsSubtitle
                    .tr(),
                onTap: () => const MonetizationRoute().go(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
