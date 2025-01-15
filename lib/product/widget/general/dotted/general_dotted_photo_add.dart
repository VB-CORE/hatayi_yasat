import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/photo_picker/photo_picker_manager.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_context.dart';
import 'package:lifeclient/product/widget/general/dotted/state/general_dotted_photo_add_provider.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/general/title/general_body_small_title.dart';

part 'extension/general_dotted_photo_add_context_extension.dart';

/// GeneralDottedPhotoAdd is a widget that is used to add photo
final class GeneralDottedPhotoAdd extends StatefulWidget {
  const GeneralDottedPhotoAdd({required this.title, super.key});

  final String title;

  @override
  State<GeneralDottedPhotoAdd> createState() => _GeneralDottedPhotoAddState();
}

class _GeneralDottedPhotoAddState extends State<GeneralDottedPhotoAdd> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralBodySmallTitle(
          widget.title,
          fontWeight: FontWeight.w500,
          color: context.general.colorScheme.onPrimaryFixedVariant,
        ),
        const EmptyBox.smallHeight(),
        ValueListenableBuilder<File?>(
          valueListenable:
              context.generalDottedPhotoAddContext.photoFileNotifier,
          builder: (BuildContext context, File? file, Widget? _) => InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: file != null
                ? context.generalDottedPhotoAddContext
                    .selectAndUpdatePhotoFromMediaSheet
                : null,
            child: GeneralDottedRectangle(
              child: SizedBox(
                height: context.sized.dynamicHeight(
                  file != null ? .3 : .15,
                ),
                child: Center(
                  child: _BodyImage(file: file),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class _BodyImage extends StatelessWidget {
  const _BodyImage({required this.file});
  final File? file;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: file == null
          ? const Row(
              children: [
                Spacer(flex: AppConstants.kTwo),
                _ImageTypeContainer.camera(),
                Spacer(),
                _ImageTypeContainer.gallery(),
                Spacer(flex: AppConstants.kTwo),
              ],
            )
          : Image.file(
              file!,
              fit: BoxFit.contain,
            ),
    );
  }
}

final class _ImageTypeContainer extends StatelessWidget {
  const _ImageTypeContainer.camera()
      : _text = LocaleKeys.component_picker_camera,
        _icon = Icons.camera_alt_rounded,
        _photoPickType = PhotoPickType.camera;
  const _ImageTypeContainer.gallery()
      : _text = LocaleKeys.component_picker_gallery,
        _icon = Icons.photo_library_rounded,
        _photoPickType = PhotoPickType.gallery;

  final String _text;
  final IconData _icon;
  final PhotoPickType _photoPickType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: CustomRadius.large,
      onTap: () async {
        await context.generalDottedPhotoAddContext
            .selectAndUpdatePhotoByPhotoPickType(_photoPickType);
      },
      child: Container(
        width: context.sized.dynamicWidth(.25),
        decoration: BoxDecoration(
          color: context.general.colorScheme.onPrimaryFixed,
          borderRadius: CustomRadius.large,
        ),
        child: Padding(
          padding: const PagePadding.generalLowAll(),
          child: _ImageTypeIconAndText(icon: _icon, text: _text.tr()),
        ),
      ),
    );
  }
}

final class _ImageTypeIconAndText extends StatelessWidget {
  const _ImageTypeIconAndText({
    required IconData icon,
    required String text,
  })  : _icon = icon,
        _text = text;

  final IconData _icon;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _icon,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
        const EmptyBox.smallWidth(),
        Text(
          _text,
          textAlign: TextAlign.start,
          style: context.general.textTheme.labelMedium?.copyWith(
            color: context.general.colorScheme.onSecondaryFixed,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
