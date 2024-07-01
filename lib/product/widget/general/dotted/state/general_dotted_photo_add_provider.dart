import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/mixin/keyboard_utility_mixin.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_context.dart';
import 'package:lifeclient/product/widget/sheet/general_media_sheet.dart';

/// [GeneralDottedPhotoAddProvider] is a provider that injects the state of
/// [GeneralDottedPhotoAddProviderState] to its child with [GeneralDottedPhotoAddContext]
final class GeneralDottedPhotoAddProvider extends StatefulWidget {
  const GeneralDottedPhotoAddProvider({
    required this.child,
    required this.onSelected,
    super.key,
  });

  final Widget child;
  final ValueChanged<File> onSelected;

  @override
  State<GeneralDottedPhotoAddProvider> createState() =>
      GeneralDottedPhotoAddProviderState();
}

final class GeneralDottedPhotoAddProviderState
    extends State<GeneralDottedPhotoAddProvider> {
  final ValueNotifier<File?> _photoFileNotifier = ValueNotifier(null);
  ValueNotifier<File?> get photoFileNotifier => _photoFileNotifier;

  /// Update photo file with [file]
  void _updatePhoto(File? file) {
    if (file == null) return;
    if (file == _photoFileNotifier.value) return;

    _photoFileNotifier.value = file;
    setState(() {});
    Future.microtask(() {
      widget.onSelected(file);
      KeyboardUtilityMixin.closeFromSystem();
    });
  }

  Future<void> selectAndUpdatePhotoByPhotoPickType(
    PhotoPickType photoPickType,
  ) async {
    final file = await PhotoPickerManager(context: context)
        .pickPhoto(type: photoPickType);
    _updatePhoto(file);
  }

  Future<void> selectAndUpdatePhotoFromMediaSheet() async {
    final response = await GeneralMediaSheet.open(context);
    if (response == null) return;
    _updatePhoto(response);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDottedPhotoAddContext(
      state: this,
      child: widget.child,
    );
  }
}
