import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/monetization/data/discount_coupon_model.dart';
import 'package:lifeclient/features/monetization/provider/coupon_redeem_state.dart';
import 'package:lifeclient/features/monetization/provider/coupon_redeem_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/date_time_extension.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'widget/coupon_redeem_result_card.dart';

final class CouponRedeemView extends ConsumerStatefulWidget {
  const CouponRedeemView({required this.coupon, super.key});

  final DiscountCouponModel coupon;

  @override
  ConsumerState<CouponRedeemView> createState() => _CouponRedeemViewState();
}

final class _CouponRedeemViewState extends ConsumerState<CouponRedeemView> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    final state = ref.read(
      couponRedeemViewModelProvider(widget.coupon.documentId),
    );
    if (!state.isIdle || state.isProcessing) return;

    await ref
        .read(couponRedeemViewModelProvider(widget.coupon.documentId).notifier)
        .redeemFromQr(capture.barcodes.firstOrNull?.rawValue);
  }

  void _scanAgain() {
    ref
        .read(couponRedeemViewModelProvider(widget.coupon.documentId).notifier)
        .reset();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      couponRedeemViewModelProvider(widget.coupon.documentId),
    );

    return Scaffold(
      appBar: PageAppBar(pageTitle: LocaleKeys.monetization_redeem_title),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(controller: _controller, onDetect: _onDetect),
                if (!state.isIdle || state.isProcessing)
                  const ColoredBox(color: AppColors.navy900),
                if (state.isProcessing)
                  const Center(child: CircularProgressIndicator.adaptive()),
              ],
            ),
          ),
          Padding(
            padding: const PagePadding.generalAllLow(),
            child: Column(
              children: [
                Text(
                  widget.coupon.desc ?? '',
                  textAlign: TextAlign.center,
                  style: AppText.title,
                ),
                const EmptyBox.smallHeight(),
                _CouponRedeemResultCard(
                  result: state.result,
                  onScanAgain: _scanAgain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
