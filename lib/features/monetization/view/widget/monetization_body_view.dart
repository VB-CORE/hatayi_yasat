part of '../monetization_view.dart';

final class _MonetizationBodyView extends StatelessWidget {
  const _MonetizationBodyView({
    required this.coupons,
    required this.onDelete,
    required this.onRedeem,
    required this.onEdit,
  });

  final List<DiscountCouponModel> coupons;
  final ValueChanged<DiscountCouponModel> onDelete;
  final ValueChanged<DiscountCouponModel> onRedeem;
  final ValueChanged<DiscountCouponModel> onEdit;

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return GeneralNotFoundWidget(
        title: LocaleKeys.monetization_emptyCoupons.tr(),
      );
    }

    return ListView.separated(
      padding: const PagePadding.onlyTop(),
      separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
      itemCount: coupons.length,
      itemBuilder: (_, index) => _MonetizationCard(
        coupon: coupons[index],
        onDelete: () => onDelete(coupons[index]),
        onRedeem: () => onRedeem(coupons[index]),
        onEdit: () => onEdit(coupons[index]),
      ),
    );
  }
}
