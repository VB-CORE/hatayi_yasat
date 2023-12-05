import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/widget/animated/animated_page_change.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/sheet/general_media_sheet.dart';

/// GeneralDottedPhotoAdd is a widget that is used to add photo
final class GeneralDottedPhotoAdd extends StatefulWidget {
  const GeneralDottedPhotoAdd({
    required this.onSelected,
    super.key,
    this.height,
  });
  final double? height;
  final ValueChanged<File> onSelected;

  @override
  State<GeneralDottedPhotoAdd> createState() => _GeneralDottedPhotoAddState();
}

class _GeneralDottedPhotoAddState extends State<GeneralDottedPhotoAdd> {
  File? _photoFile;

  void _updatePhoto(File? file) {
    if (file == null) return;
    if (file == _photoFile) return;
    setState(() {
      _photoFile = file;
    });
    Future.microtask(() {
      widget.onSelected(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final response = await GeneralMediaSheet.open(context);
        _updatePhoto(response);
      },
      child: GeneralDottedRectangle(
        child: Opacity(
          opacity: _photoFile != null ? 1 : .5,
          child: SizedBox(
            height: context.sized.dynamicHeight(_photoFile != null ? .4 : .2),
            child: Center(
              child: _BodyImage(photoFile: _photoFile),
            ),
          ),
        ),
      ),
    );
  }
}

final class _BodyImage extends StatelessWidget {
  const _BodyImage({
    required File? photoFile,
  }) : _photoFile = photoFile;

  final File? _photoFile;

  @override
  Widget build(BuildContext context) {
    return AnimatedPageSwitch(
      crossFadeState: _photoFile != null
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      secondChild: _photoFile != null
          ? Image.file(_photoFile!)
          : const SizedBox.shrink(),
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(AppIcons.addPhoto),
          GeneralBodyTitle(LocaleKeys.button_addPhoto.tr()),
        ],
      ),
    );
  }
}
