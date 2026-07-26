import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/widget/wall_composer.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/extension/file_size_extension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/sheet/media_photo_sheet.dart';

mixin WallComposerMixin
    on ConsumerState<WallComposer>, AppProviderMixin<WallComposer> {
  final TextEditingController postController = TextEditingController();

  File? _postImageFile;
  File? get postImageFile => _postImageFile;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  Future<void> pickPostImage() async {
    final type = await MediaOrPhoto.openSheet(context);
    if (type == null || !mounted) return;

    final file = await PhotoPickerManager(context: context).pickPhoto(
      type: type,
    );
    if (file == null || !mounted) return;
    setState(() => _postImageFile = file);
  }

  void removePostImage() => setState(() => _postImageFile = null);

  Future<void> submitPost() async {
    final content = postController.text.trim();
    final imageFile = _postImageFile;
    if (content.isEmpty && imageFile == null) return;

    if (imageFile != null && await imageFile.exceedsUploadLimit) {
      appProvider.showSnackbarMessage(
        LocaleKeys.message_imageTooLarge.tr(args: [FileSizeX.uploadLimitLabel]),
      );
      return;
    }

    final isAdded = await ref
        .read(groupWallViewModelProvider(widget.groupId).notifier)
        .addPost(content, imageFile: imageFile);
    if (isAdded || !mounted) {
      postController.clear();
      setState(() => _postImageFile = null);
      return;
    }

    appProvider.showSnackbarMessage(LocaleKeys.message_somethingWentWrong.tr());
  }
}
