import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/items/colors_custom.dart';
import 'package:vbaseproject/product/model/constant/project_general_constant.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/border/dotted_border_custom.dart';
import 'package:vbaseproject/product/widget/package/photo_picker/add_photo_mixin.dart';

class DottedAddPhotoButton extends StatefulWidget {
  const DottedAddPhotoButton({required this.onSelected, super.key});
  final ValueChanged<File> onSelected;
  @override
  State<DottedAddPhotoButton> createState() => _DottedAddPhotoButtonState();
}

class _DottedAddPhotoButtonState extends State<DottedAddPhotoButton>
    with AddPhotoMixin {
  @override
  Widget build(BuildContext context) {
    return DottedBorderCustom(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.medium,
          ),
        ),
        onPressed: fetchAndAddNewImage,
        child: SizedBox(
          child: Center(
            child: AnimatedCrossFade(
              crossFadeState: photoFile == null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: ProjectGeneralConstant.durationLow,
              secondChild: _FileImageWithUpdate(
                onUpdateTap: fetchAndAddNewImage,
                file: photoFile,
              ),
              firstChild: const _EmptyAddPhoto(),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyAddPhoto extends StatelessWidget {
  const _EmptyAddPhoto();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.all() + const PagePadding.verticalHigh(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_a_photo_outlined),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: const Text(LocaleKeys.button_addPhoto).tr(),
          )
        ],
      ),
    );
  }
}

class _FileImageWithUpdate extends StatelessWidget {
  const _FileImageWithUpdate({required this.onUpdateTap, required this.file});
  final VoidCallback onUpdateTap;
  final File? file;
  @override
  Widget build(BuildContext context) {
    if (file == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Image.file(file!),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: ColorsCustom.sambacus,
            ),
            onPressed: onUpdateTap,
            icon: const Icon(
              Icons.edit,
              color: ColorsCustom.white,
            ),
          ),
        )
      ],
    );
  }
}
