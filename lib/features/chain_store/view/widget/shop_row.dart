part of '../chain_store_detail_view.dart';

final class _ShopRow extends StatelessWidget {
  const _ShopRow({required this.shop});

  final StoreModel shop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyBottomLow(),
      child: Semantics(
        button: true,
        label: shop.name,
        child: InkWell(
          onTap: () => _ShopSheet.show(context, shop),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: context.appColors.ink100),
            ),
            padding: const PagePadding.generalAllLow(),
            child: Row(
              spacing: AppSpacing.sm,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralContentSubTitle(
                        value: shop.name,
                        maxLine: 2,
                        fontWeight: FontWeight.w700,
                        color: context.appColors.ink800,
                      ),
                      if (shop.category != null)
                        GeneralContentSmallTitle(
                          value: shop.category!.displayName,
                        ),
                    ],
                  ),
                ),
                _ShopActionButton(
                  icon: AppIcons.directions,
                  tooltipKey: LocaleKeys.general_action_directions,
                  onTap: () => LinkActions.directions(context, shop.address),
                  foreground: context.appColors.ink600,
                  background: context.appColors.surface,
                  borderColor: context.appColors.ink100,
                ),
                _ShopActionButton(
                  icon: AppIcons.phone,
                  tooltipKey: LocaleKeys.general_action_call,
                  onTap: () => LinkActions.call(context, shop.phone),
                  foreground: context.appColors.surface,
                  background: context.appColors.olive,
                  borderColor: context.appColors.olive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _ShopActionButton extends StatelessWidget {
  const _ShopActionButton({
    required this.icon,
    required this.tooltipKey,
    required this.onTap,
    required this.foreground,
    required this.background,
    required this.borderColor,
  });

  final IconData icon;
  final String tooltipKey;
  final VoidCallback onTap;
  final Color foreground;
  final Color background;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipKey.tr(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: borderColor),
          ),
          child: SizedBox.square(
            dimension: WidgetSizes.spacingXxl5,
            child: Center(
              child: Icon(icon, color: foreground, size: AppIconSizes.medium),
            ),
          ),
        ),
      ),
    );
  }
}
