import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/package/photo_picker/photo_picker_manager.dart';

class MediaOrPhoto extends StatelessWidget {
  const MediaOrPhoto({super.key});

  static Future<PhotoPickType?> openSheet(BuildContext context) async {
    return showModalBottomSheet<PhotoPickType?>(
      context: context,
      builder: (context) {
        return const MediaOrPhoto();
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
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text(LocaleKeys.component_picker_camera).tr(),
              onTap: () {
                context.route.pop(PhotoPickType.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image_outlined),
              title: const Text(LocaleKeys.component_picker_gallery).tr(),
              onTap: () {
                context.route.pop(PhotoPickType.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
