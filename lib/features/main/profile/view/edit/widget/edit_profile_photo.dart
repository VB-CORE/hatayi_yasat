import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/circle_avatar/custom_user_avatar.dart';

final class EditProfilePhoto extends StatelessWidget {
  const EditProfilePhoto({
    required this.userName,
    required this.onTap,
    this.photoFile,
    this.photoUrl,
    super.key,
  });

  final String userName;
  final File? photoFile;
  final String? photoUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = context.sized.dynamicWidth(0.14);

    return Center(
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.navy200,
                      width: WidgetSizes.spacingXSS,
                    ),
                  ),
                  child: photoFile != null
                      ? CircleAvatar(
                          radius: radius,
                          backgroundImage: FileImage(photoFile!),
                        )
                      : CustomUserAvatar(
                          userName: userName,
                          imageUrl: photoUrl,
                          radius: radius,
                        ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white,
                        width: WidgetSizes.spacingXSS,
                      ),
                    ),
                    child: const Padding(
                      padding: PagePadding.allVeryLow(),
                      child: Icon(
                        AppIcons.camera,
                        size: AppIconSizes.medium,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(LocaleKeys.auth_editProfile_changePhoto.tr()),
          ),
        ],
      ),
    );
  }
}
