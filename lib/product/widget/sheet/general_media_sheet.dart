import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/constants/index.dart';

/// GeneralMediaSheet is a widget that is used to select media
/// [open] is a function that is used to open sheet
/// Return:
///  - [File] if user select photo
///  - [Null] if user cancel

final class GeneralMediaSheet extends StatelessWidget {
  const GeneralMediaSheet({super.key});

  static Future<File?> open(BuildContext context) async {
    final type = await showModalBottomSheet<PhotoPickType>(
      context: context,
      builder: (context) {
        return const GeneralMediaSheet();
      },
    );
    if (type == null || !context.mounted) return null;
    return PhotoPickerManager(context: context).pickPhoto(type: type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.vertical12Symmetric(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(AppIcons.camera),
              title: const Text(LocaleKeys.component_picker_camera).tr(),
              onTap: () => context.route.pop(PhotoPickType.camera),
            ),
            ListTile(
              leading: const Icon(AppIcons.gallery),
              title: const Text(LocaleKeys.component_picker_gallery).tr(),
              onTap: () => context.route.pop(PhotoPickType.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
