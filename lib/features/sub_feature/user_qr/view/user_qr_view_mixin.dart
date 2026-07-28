import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/sub_feature/user_qr/model/user_qr_payload.dart';
import 'package:lifeclient/features/sub_feature/user_qr/view/user_qr_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/share/custom_share.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/widget/general/qr_image/qr_image_exporter.dart';

mixin UserQrViewMixin on State<UserQrView>, ProjectDependencyMixin {
  String? get userQrUrl {
    final uid = authService.cachedUser?.uid;
    if (uid == null || uid.isEmpty) return null;
    return UserQrPayload.encode(uid);
  }

  Future<void> copyQrUrl() async {
    final url = userQrUrl;
    if (url == null) return;
    await url.copyToClipboard();
    appProvider.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Center(child: Text(LocaleKeys.message_copiedToClipboard.tr())),
        backgroundColor: AppColors.navy,
      ),
    );
  }

  Future<void> shareQrUrl() async {
    final url = userQrUrl;
    if (url == null) return;

    final bytes = await QrImageExporter.toImageBytes(url);
    if (bytes == null || !mounted) return;

    await CustomShare.shareImage(
      context,
      bytes: bytes,
      fileName: '${url.split('/').last}.png',
      subject: LocaleKeys.userQr_shareSubject.tr(),
    );
  }
}
