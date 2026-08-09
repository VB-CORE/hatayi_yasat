part of '../chain_store_detail_view.dart';

abstract final class _ShopSheet {
  static Future<void> show(BuildContext context, StoreModel shop) async {
    await DetailSheet.show(
      context: context,
      children: [
        _ShopSheetHeader(shop: shop),
        if (shop.phone.isNotEmpty)
          DetailActionRow(
            labelKey: LocaleKeys.chain_stores_shopPhoneLabel,
            value: shop.phone,
            icon: AppIcons.phone,
            primaryIcon: AppIcons.phone,
            primaryTooltipKey: LocaleKeys.general_action_call,
            onPrimary: () => LinkActions.call(context, shop.phone),
            accent: context.appColors.olive,
          ),
        if (shop.address != null)
          DetailActionRow(
            labelKey: LocaleKeys.chain_stores_shopAddressLabel,
            value: shop.address!,
            icon: AppIcons.location,
            primaryIcon: AppIcons.directions,
            primaryTooltipKey: LocaleKeys.general_action_directions,
            onPrimary: () => LinkActions.directions(context, shop.address),
            accent: context.appColors.olive,
          ),
      ],
    );
  }
}

final class _ShopSheetHeader extends StatelessWidget {
  const _ShopSheetHeader({required this.shop});

  final StoreModel shop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        if (shop.category != null)
          GeneralContentSmallTitle(
            value: shop.category!.displayName.toUpperCase(),
          ),
        GeneralContentTitle(value: shop.name),
      ],
    );
  }
}
