part of '../main_tab_view.dart';

final class _DiscoverMenuOverlay {
  const _DiscoverMenuOverlay._();

  static Future<void> show(BuildContext context) {
    final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight;
    final topInset = MediaQuery.paddingOf(context).top + appBarHeight;
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: LocaleKeys.navigationTabs_explore.tr(),
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              top: topInset,
              left: kZero,
              right: kZero,
              bottom: kZero,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: WidgetSizes.spacingXs,
                  sigmaY: WidgetSizes.spacingXs,
                ),
                child: Container(
                  color: context.appColors.navy.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              top: topInset,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: const _DiscoverMenuCard(),
            ),
          ],
        );
      },
    );
  }
}

final class _DiscoverMenuCard extends StatelessWidget {
  const _DiscoverMenuCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.surface,
      elevation: WidgetSizes.spacingXs,
      shadowColor: context.appColors.navy.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Padding(
        padding: const PagePadding.generalAllLow(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _DiscoverMenuHeader(),
            const EmptyBox.smallHeight(),
            _DiscoverMenuItem(
              icon: AppIcons.accountBalance,
              iconBackgroundColor: context.appColors.navy,
              itemLabel: LocaleKeys.specialAgency_title,
              destination: () {
                const SpecialAgencyRoute().go(context);
              },
            ),
            _DiscoverMenuItem(
              icon: AppIcons.store,
              iconBackgroundColor: context.appColors.coral,
              itemLabel: LocaleKeys.chain_stores_title,
              destination: () {
                const ChainStoresRoute().go(context);
              },
            ),
            _DiscoverMenuItem(
              icon: AppIcons.camera,
              iconBackgroundColor: context.appColors.teal,
              itemLabel: LocaleKeys.tourismView_title,
              destination: () {
                const TurismRoute().go(context);
              },
            ),
            _DiscoverMenuItem(
              icon: AppIcons.link,
              iconBackgroundColor: context.appColors.olive,
              itemLabel: LocaleKeys.usefulLink_title,
              destination: () {
                const UsefulLinksRoute().go(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

final class _DiscoverMenuHeader extends StatelessWidget {
  const _DiscoverMenuHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.icons.icAppTransparent.image(
          height: WidgetSizes.spacingXl,
          width: WidgetSizes.spacingXl,
        ),
        const EmptyBox(width: WidgetSizes.spacingS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralContentSubTitle(
                value: LocaleKeys.project_name.tr(),
                fontWeight: FontWeight.w700,
              ),
              Text(
                LocaleKeys.navigationTabs_explore.tr().toUpperCase(),
                style: AppText.eyebrow,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AppIcons.close, color: context.appColors.ink300),
        ),
      ],
    );
  }
}

final class _DiscoverMenuItem extends StatelessWidget {
  const _DiscoverMenuItem({
    required this.icon,
    required this.iconBackgroundColor,
    required this.itemLabel,
    required this.destination,
  });

  final IconData icon;
  final Color iconBackgroundColor;
  final String itemLabel;
  final VoidCallback destination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () {
        Navigator.of(context).pop();
        destination();
      },
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
              child: GeneralContentSubTitle(
                value: itemLabel.tr(),
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(AppIcons.rightSelect, color: context.appColors.ink300),
          ],
        ),
      ),
    );
  }
}
