import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_state.dart';
import 'package:lifeclient/features/community/rate/provider/rate_community_view_model.dart';
import 'package:lifeclient/features/community/rate/view/widget/rate_sheet_factory.dart';
import 'package:lifeclient/features/place_detail/view/place_detail_view.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_args.dart';
import 'package:lifeclient/features/place_detail/view_model/place_detail_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/dialog/login_required_dialog.dart';

mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  late final PlaceDetailArgs args;

  StoreModel get store =>
      ref.read(placeDetailViewModelProvider(args)).storeModel;

  @override
  void initState() {
    super.initState();
    args = PlaceDetailArgs(id: widget.id, store: widget.store);
    ref.listenManual(
      rateCommunityViewModelProvider(widget.id),
      _onRateStatusChanged,
    );
  }

  void _onRateStatusChanged(RateCommunityState? prev, RateCommunityState next) {
    final vote = next.vote ?? prev?.vote;
    final notifier = ref.read(placeDetailViewModelProvider(args).notifier);
    switch (next.status) {
      case RateActionSucceeded(action: RateAction.create):
        final score = vote?.score;
        if (score == null) return;
        notifier.applyRatingDelta(scoreDelta: score, countDelta: 1);
      case RateActionSucceeded(action: RateAction.delete):
        final score = vote?.score;
        if (score == null) return;
        notifier.applyRatingDelta(scoreDelta: -score, countDelta: -1);
      case _:
        break;
    }
  }

  Future<void> onCall() {
    ref.read(placeDetailViewModelProvider(args).notifier).logCallTap();
    return RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: store.phone,
    );
  }

  Future<void> onOpenMaps(GeoPoint latLong) {
    ref.read(placeDetailViewModelProvider(args).notifier).logDirectionsTap();
    return '${latLong.latitude},${latLong.longitude}'.ext.launchMaps();
  }

  Future<void> onComment() async {
    if (ref.read(authViewModelProvider) is! Authenticated) {
      await LoginRequiredDialog.show(context);
      return;
    }
    await RateSheetFactory.showRateCard(context, placeId: widget.id);
  }

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
