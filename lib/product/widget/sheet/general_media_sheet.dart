import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/photo_picker/photo_picker_manager.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

/// GeneralMediaSheet is a widget that is used to select media
/// [open] is a function that is used to open sheet
/// Return:
///  - [File] if user select photo
///  - [Null] if user cancel

final class GeneralMediaSheet extends StatelessWidget {
  const GeneralMediaSheet({super.key});

  static Future<File?> open(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      builder: (context) {
        return const GeneralMediaSheet();
      },
    );
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
              onTap: () async {
                final file = await PhotoPickerManager(context: context)
                    .pickPhoto(type: PhotoPickType.camera);

                if (file == null) return;
                if (!context.mounted) return;
                await context.route.pop(file);
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.gallery),
              title: const Text(LocaleKeys.component_picker_gallery).tr(),
              onTap: () async {
                final file = await PhotoPickerManager(context: context)
                    .pickPhoto(type: PhotoPickType.gallery);

                if (file == null) return;
                if (!context.mounted) return;
                await context.route.pop(file);
              },
            ),
          ],
        ),
      ),
    );
  }
}
