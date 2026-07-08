part of '../monetization_view.dart';

final class _MonetizationBodyView extends StatelessWidget {
  const _MonetizationBodyView({required this.coupons});

  final List<DiscountCouponModel> coupons;

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
      itemBuilder: (_, index) => _MonetizationCard(coupon: coupons[index]),
    );
  }
}
