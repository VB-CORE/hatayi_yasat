import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/rate/model/mock_auth.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/features/place_detail/view/place_detail_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/dialog/login_required_dialog.dart';

mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  final double patternHeightFactor = .25;

  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> onCall() {
    return RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: widget.store.phone,
    );
  }

  Future<void> onComment() async {
    if (!MockAuth.isAuthenticated) {
      await LoginRequiredDialog.show(context);
      return;
    }
    await RateSheetFactory.showRateCard(
      context,
      placeId: widget.store.documentId,
    );
  }

  Future<void> onCopyAddress() async {
    final address = widget.store.address;
    if (address.ext.isNullOrEmpty) return;

    await address!.copyToClipboard();
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Center(
            child: Text(LocaleKeys.message_copiedToClipboard.tr()),
          ),
          backgroundColor: AppColors.navy,
        ),
      );
  }
}
