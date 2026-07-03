part of '../monetization_view.dart';

typedef _CouponAction = Future<void> Function(DiscountCouponModel coupon);

final class _MonetizationBodyView extends ConsumerWidget {
  const _MonetizationBodyView({
    required this.state,
    required this.onEditCoupon,
    required this.onDeleteCoupon,
  });

  final MonetizationState state;
  final _CouponAction onEditCoupon;
  final _CouponAction onDeleteCoupon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const PagePadding.onlyTop(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: state.coupons.length,
      itemBuilder: (context, index) {
        final coupon = state.coupons[index];
        final isActive = coupon.isActive == true;
        final accentColor = isActive
            ? ColorsCustom.underlinePurple
            : ColorsCustom.darkGray;
        final labelColor = isActive
            ? ColorsCustom.sambacus
            : ColorsCustom.darkGray;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            CustomHorizontalTicketcher(
              decoration: CustomHorizontalTicketcher.ticketDecoration(
                isSelected: isActive,
              ),
              sections: [
                Section(
                  widthFactor: 1,
                  child: Padding(
                    padding: const PagePadding.all(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${coupon.discountRate}%',
                          style: context.general.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        Text(
                          LocaleKeys.monetization_discountCodeLabel.tr(),
                          style: context.general.textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: labelColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Section(
                  widthFactor: 2,
                  child: Padding(
                    padding: const PagePadding.allLow(),
                    child: Column(
                      children: [
                        Text(
                          '${coupon.code}',
                          style: context.general.textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                        ),
                        Text(
                          '${coupon.name}',
                          style: context.general.textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: labelColor,
                              ),
                        ),
                        Text(
                          LocaleKeys.monetization_expiryDateLabel.tr(),
                          style: context.general.textTheme.bodyMedium?.copyWith(
                            color: ColorsCustom.darkGray,
                          ),
                        ),
                        if (coupon.expiresAt != null)
                          Text(
                            DateFormat.yMMMEd(
                              context.locale.toLanguageTag(),
                            ).add_jm().format(
                              coupon.expiresAt!.toLocal(),
                            ),
                            style: context.general.textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: labelColor,
                                ),
                          ),
                        if (!isActive)
                          Text(
                            LocaleKeys.monetization_inactive.tr(),
                            style: context.general.textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsCustom.imperilRead,
                                ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _CouponActionsMenu(
                coupon: coupon,
                onEditCoupon: onEditCoupon,
                onDeleteCoupon: onDeleteCoupon,
              ),
            ),
          ],
        );
      },
    );
  }
}

final class _CouponActionsMenu extends StatelessWidget {
  const _CouponActionsMenu({
    required this.coupon,
    required this.onEditCoupon,
    required this.onDeleteCoupon,
  });

  final DiscountCouponModel coupon;
  final _CouponAction onEditCoupon;
  final _CouponAction onDeleteCoupon;

  static const _editAction = 'edit';
  static const _deleteAction = 'delete';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        AppIcons.moreDots,
        color: context.general.colorScheme.primary,
      ),
      onSelected: (value) {
        switch (value) {
          case _editAction:
            unawaited(onEditCoupon(coupon));
          case _deleteAction:
            unawaited(onDeleteCoupon(coupon));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _editAction,
          child: Row(
            children: [
              Icon(
                AppIcons.edit,
                color: context.general.colorScheme.primary,
              ),
              const EmptyBox.smallWidth(),
              Text(LocaleKeys.monetization_editCoupon.tr()),
            ],
          ),
        ),
        PopupMenuItem(
          value: _deleteAction,
          child: Row(
            children: [
              const Icon(
                AppIcons.delete,
                color: ColorsCustom.imperilRead,
              ),
              const EmptyBox.smallWidth(),
              Text(
                LocaleKeys.monetization_deleteCoupon.tr(),
                style: context.general.textTheme.bodyMedium?.copyWith(
                  color: ColorsCustom.imperilRead,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
