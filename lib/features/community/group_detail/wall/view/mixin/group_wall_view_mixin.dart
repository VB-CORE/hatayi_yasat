import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/features/community/group_detail/wall/provider/group_wall_view_model.dart';
import 'package:lifeclient/features/community/group_detail/wall/view/group_wall_view.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/sheet/media_photo_sheet.dart';

mixin GroupWallViewMixin
    on ConsumerState<GroupWallView>, AppProviderMixin<GroupWallView> {
  final TextEditingController postController = TextEditingController();

  File? _postImageFile;
  File? get postImageFile => _postImageFile;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(groupWallViewModelProvider.notifier).fetchPosts(widget.model.id);
    });
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  Future<void> pickPostImage() async {
    final type = await MediaOrPhoto.openSheet(context);
    if (type == null) return;
    if (!mounted) return;
    final file = await PhotoPickerManager(context: context).pickPhoto(
      type: type,
    );
    if (file == null) return;
    setState(() => _postImageFile = file);
  }

  void removePostImage() => setState(() => _postImageFile = null);

  void submitPost() {
    final content = postController.text.trim();
    if (content.isEmpty && _postImageFile == null) return;
    ref
        .read(groupWallViewModelProvider.notifier)
        .addPost(content, imageFile: _postImageFile);
    postController.clear();
    setState(() => _postImageFile = null);
  }
}
