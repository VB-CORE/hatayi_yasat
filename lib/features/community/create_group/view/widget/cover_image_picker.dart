import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class CoverImagePicker extends StatelessWidget {
  const CoverImagePicker({
    required this.imageFile,
    required this.onTap,
    super.key,
  });

  final File? imageFile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CustomRadius.large,
      child: SizedBox(
        height: context.sized.dynamicHeight(0.22),
        width: context.sized.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageFile != null)
              Image.file(imageFile!, fit: BoxFit.cover)
            else
              ColoredBox(
                color: context.general.colorScheme.outline,
                child: const Center(
                  child: Icon(
                    AppIcons.gallery,
                    size: AppIconSizes.xLarge,
                    color: AppColors.ink200,
                  ),
                ),
              ),
            Positioned(
              right: WidgetSizes.spacingM,
              bottom: WidgetSizes.spacingM,
              child: _SelectImageButton(onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SelectImageButton extends StatelessWidget {
  const _SelectImageButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: WidgetSizes.spacingXSS,
      borderRadius: CustomRadius.xxLarge,
      child: InkWell(
        onTap: onTap,
        borderRadius: CustomRadius.xxLarge,
        child: Padding(
          padding:
              const PagePadding.horizontal16Symmetric() +
              const PagePadding.vertical8Symmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AppIcons.camera,
                size: AppIconSizes.medium,
                color: AppColors.coral,
              ),
              const EmptyBox.smallWidth(),
              GeneralContentSubTitle(
                value: LocaleKeys.community_createGroup_selectImage.tr(),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
