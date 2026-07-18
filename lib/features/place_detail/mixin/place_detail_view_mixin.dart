import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/features/place_detail/view/place_detail_view.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_args.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';

mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  static const double patternHeightFactor = .25;

  late final ScrollController scrollController;
  late final PlaceDetailArgs args;

  StoreModel get store =>
      ref.read(placeDetailViewModelProvider(args)).storeModel;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    args = PlaceDetailArgs(id: widget.id, store: widget.store);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> onCall() =>
      RedirectionMixin.openToPhone(context: context, phoneNumber: store.phone);

  Future<void> onComment() =>
      RateSheetFactory.showRateCard(context, placeId: widget.id);

  Future<void> onCopyAddress() async {
    final address = store.address;
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
