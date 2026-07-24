import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/package/image/custom_circle_network_image.dart';
import 'package:lifeclient/product/utility/decorations/custom_circle_radius.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';

final class CustomUserAvatar extends StatelessWidget {
  const CustomUserAvatar({
    required this.userName,
    this.imageUrl,
    this.radius = CustomCircleRadius.medium,
    this.backgroundColor = AppColors.coral,
    this.foregroundColor = AppColors.white,
    super.key,
  });

  final String userName;
  final String? imageUrl;
  final double radius;
  final Color backgroundColor;
  final Color foregroundColor;

  bool get _hasImage => imageUrl?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    if (_hasImage) {
      return CustomCircleNetworkImage(imageUrl: imageUrl, radius: radius);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        userName.initials(),
        style: AppText.body.copyWith(
          color: foregroundColor,
          fontWeight: .bold,
          fontSize: radius * 0.75,
        ),
      ),
    );
  }
}
