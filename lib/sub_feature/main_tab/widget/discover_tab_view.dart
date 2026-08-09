import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/community/widget/soft_icon_box.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class DiscoverTabView extends StatelessWidget {
  const DiscoverTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: SafeArea(
        child: ListView(
          padding: const PagePadding.horizontal16Symmetric(),
          children: [
            const _DiscoverTabHeader(),
            const EmptyBox.smallHeight(),
            _DiscoverTabItem(
              icon: AppIcons.accountBalance,
              iconBackgroundColor: context.appColors.navy,
              itemLabel: LocaleKeys.specialAgency_title,
              descriptionLabel:
                  LocaleKeys.navigationTabs_exploreMenu_institutionsDescription,
              destination: () => const SpecialAgencyRoute().go(context),
            ),
            _DiscoverTabItem(
              icon: AppIcons.store,
              iconBackgroundColor: context.appColors.coral,
              itemLabel: LocaleKeys.chain_stores_title,
              descriptionLabel:
                  LocaleKeys.navigationTabs_exploreMenu_marketsDescription,
              destination: () => const ChainStoresRoute().go(context),
            ),
            _DiscoverTabItem(
              icon: AppIcons.camera,
              iconBackgroundColor: context.appColors.teal,
              itemLabel: LocaleKeys.tourismView_title,
              descriptionLabel:
                  LocaleKeys.navigationTabs_exploreMenu_touristDescription,
              destination: () => const TurismRoute().go(context),
            ),
            _DiscoverTabItem(
              icon: AppIcons.link,
              iconBackgroundColor: context.appColors.olive,
              itemLabel: LocaleKeys.usefulLink_title,
              descriptionLabel:
                  LocaleKeys.navigationTabs_exploreMenu_linksDescription,
              destination: () => const UsefulLinksRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}

final class _DiscoverTabHeader extends StatelessWidget {
  const _DiscoverTabHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const PagePadding.onlyTopMedium() +
          const PagePadding.onlyBottomNormal(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          GeneralContentSmallTitle(
            value: LocaleKeys.navigationTabs_exploreMenu_eyebrow.tr(),
            color: context.appColors.coral,
            fontWeight: FontWeight.w800,
          ),
          GeneralContentTitle(
            value: LocaleKeys.navigationTabs_exploreMenu_title.tr(),
          ),
          GeneralContentSubTitle(
            value: LocaleKeys.navigationTabs_exploreMenu_description.tr(),
          ),
        ],
      ),
    );
  }
}

final class _DiscoverTabItem extends StatelessWidget {
  const _DiscoverTabItem({
    required this.icon,
    required this.iconBackgroundColor,
    required this.itemLabel,
    required this.descriptionLabel,
    required this.destination,
  });

  final IconData icon;
  final Color iconBackgroundColor;
  final String itemLabel;
  final String descriptionLabel;
  final VoidCallback destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: context.appColors.ink100),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: destination,
          child: Padding(
            padding: const PagePadding.generalAllLow(),
            child: Row(
              children: [
                SoftIconBox(
                  icon: icon,
                  iconColor: context.appColors.surface,
                  backgroundColor: iconBackgroundColor,
                  backgroundOpacity: 1,
                ),
                const EmptyBox(width: WidgetSizes.spacingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralContentSubTitle(
                        value: itemLabel.tr(),
                        fontWeight: FontWeight.bold,
                      ),
                      GeneralContentSmallTitle(value: descriptionLabel.tr()),
                    ],
                  ),
                ),
                Icon(AppIcons.rightSelect, color: context.appColors.ink300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
