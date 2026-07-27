import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/share/custom_share.dart';
import 'package:lifeclient/product/utility/constants/duration_constant.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/general/qr_image/qr_image_exporter.dart';

mixin UserQrViewMixin
    on ConsumerState<UserQrView>, AppProviderMixin<UserQrView> {
  final ValueNotifier<bool> isQrVisible = ValueNotifier(false);

  String get qrData => ref.read(authViewModelProvider).user?.uid ?? '';

  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.delayed(
        DurationConstant.durationVeryLow,
      ).then((value) => isQrVisible.value = true),
    );
  }

  @override
  void dispose() {
    isQrVisible.dispose();
    super.dispose();
  }

  Future<void> shareQrData() async {
    final bytes = await QrImageExporter.toImageBytes(qrData);
    if (bytes == null || !mounted) return;

    await CustomShare.shareImage(
      context,
      bytes: bytes,
      fileName: '$qrData.png',
      subject: LocaleKeys.userQr_shareSubject.tr(),
    );
  }
}
