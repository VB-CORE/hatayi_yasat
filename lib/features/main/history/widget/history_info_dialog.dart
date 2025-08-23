import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/firebase_remote_enums.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';

@immutable
final class HistoryInfoDialog extends StatelessWidget {
  const HistoryInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
      ),
      content: _DialogContent(),
      actions: [
        _DialogAction(),
      ],
    );
  }
}

/// Dialog content with image placeholder and description
final class _DialogContent extends StatelessWidget {
  const _DialogContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomNetworkImage(
          imageUrl: FirebaseRemoteEnums.memoryForestImage.valueString,
        ),
        const SizedBox(height: AppIconSizes.xMedium),
        const _DescriptionText(),
        const SizedBox(height: AppIconSizes.smallX),
        const _InfoBox(),
      ],
    );
  }
}

/// Main description text
final class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.historyPage_welcomeDescription.tr(),
      style: context.general.textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}

/// Info box with add photo information
final class _InfoBox extends StatelessWidget {
  const _InfoBox();

  static const double _opacity = 0.1;
  static const double _borderOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.generalAllLow(),
      decoration: BoxDecoration(
        color: ColorsCustom.brandeisBlue.withValues(alpha: _opacity),
        borderRadius: CustomRadius.small,
        border: Border.all(
          color: ColorsCustom.brandeisBlue.withValues(alpha: _borderOpacity),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            AppIcons.addPhoto,
            color: ColorsCustom.brandeisBlue,
            size: AppIconSizes.medium,
          ),
          const SizedBox(width: AppIconSizes.small),
          Expanded(
            child: Text(
              LocaleKeys.historyPage_addPhotoInfo.tr(),
              style: context.general.textTheme.bodySmall?.copyWith(
                color: ColorsCustom.brandeisBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dialog action button
final class _DialogAction extends StatelessWidget {
  const _DialogAction();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        LocaleKeys.button_understood.tr(),
        style: context.general.textTheme.labelLarge?.copyWith(
          color: ColorsCustom.brandeisBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
