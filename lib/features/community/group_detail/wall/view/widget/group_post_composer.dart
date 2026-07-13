import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/features/community/widget/community_send_button.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

@immutable
final class GroupPostComposer extends StatelessWidget {
  const GroupPostComposer({
    required this.controller,
    required this.imageFile,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final File? imageFile;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: CustomRadius.large),
      child: Padding(
        padding: const PagePadding.generalCardAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ComposerPill(
              controller: controller,
              hasImage: imageFile != null,
              onPickImage: onPickImage,
              onSubmit: onSubmit,
            ),
            if (imageFile != null) ...[
              const EmptyBox.smallHeight(),
              _ImagePreview(imageFile: imageFile!, onRemove: onRemoveImage),
            ],
          ],
        ),
      ),
    );
  }
}

final class _ComposerPill extends StatelessWidget {
  const _ComposerPill({
    required this.controller,
    required this.hasImage,
    required this.onPickImage,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool hasImage;
  final VoidCallback onPickImage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.ink50,
        borderRadius: CustomRadius.xxLarge,
      ),
      child: Padding(
        padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric(),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: LocaleKeys.community_groupDetail_wall_composerHint
                      .tr(),
                  isCollapsed: true,
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              onTap: onPickImage,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const PagePadding.allVeryLow(),
                child: Icon(
                  AppIcons.gallery,
                  size: AppIconSizes.medium,
                  color: hasImage ? AppColors.coral : AppColors.navy300,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                final canSubmit = value.text.trim().isNotEmpty || hasImage;
                return AnimatedSize(
                  duration: Durations.short4,
                  child: canSubmit
                      ? CommunitySendButton(onTap: onSubmit)
                      : const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.imageFile, required this.onRemove});

  final File imageFile;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: CustomRadius.medium,
      child: Stack(
        children: [
          Image.file(
            imageFile,
            height: context.sized.dynamicHeight(0.14),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: WidgetSizes.spacingXxs,
            right: WidgetSizes.spacingXxs,
            child: InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: CircleAvatar(
                radius: AppIconSizes.smallX,
                backgroundColor: AppColors.navy900.withValues(alpha: 0.6),
                child: const Icon(
                  AppIcons.close,
                  size: AppIconSizes.xMedium,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
