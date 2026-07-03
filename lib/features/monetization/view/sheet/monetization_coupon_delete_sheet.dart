import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/divider/sheet_gap_divider.dart';
import 'package:lifeclient/product/widget/general/general_button.dart';
import 'package:lifeclient/product/widget/general/title/general_content_sub_title.dart';

@immutable
final class MonetizationCouponDeleteSheet extends StatelessWidget {
  const MonetizationCouponDeleteSheet({super.key});

  static Future<bool> show({required BuildContext context}) async {
    return await showModalBottomSheet<bool>(
          context: context,
          useSafeArea: true,
          builder: (context) => const MonetizationCouponDeleteSheet(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetGapDivider(),
          GeneralContentSubTitle(
            value: LocaleKeys.monetization_deleteCoupon.tr(),
            fontWeight: FontWeight.bold,
          ),
          const EmptyBox.smallHeight(),
          GeneralContentSubTitle(
            value: LocaleKeys.monetization_deleteCouponConfirm.tr(),
            maxLine: 3,
          ),
          const EmptyBox.smallHeight(),
          GeneralButtonV2.active(
            action: () => context.route.pop(true),
            label: LocaleKeys.monetization_deleteCoupon.tr(),
          ),
          TextButton(
            onPressed: () => context.route.pop(false),
            child: Text(LocaleKeys.button_cancel.tr()),
          ),
        ],
      ),
    );
  }
}
