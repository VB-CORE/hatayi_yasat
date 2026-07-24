import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/product/package/image/custom_circle_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:lifeclient/product/widget/general/index.dart';

/// Profil görseli varsa ağdan yuvarlak gösterir; yoksa [name]'in baş
/// harflerini renkli bir daire içinde gösterir.
@immutable
final class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.name,
    this.imageUrl,
    this.radius = AppIconSizes.medium,
    this.backgroundColor = AppColors.coral,
    this.singleLetter = false,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final double radius;
  final Color backgroundColor;
  final bool singleLetter;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url != null && url.isNotEmpty) {
      return CustomCircleNetworkImage(imageUrl: url, radius: radius);
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: GeneralContentSmallTitle(
        value: name.initials(take: singleLetter ? 1 : 2),
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
