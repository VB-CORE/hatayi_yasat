import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/icon/icon_with_text.dart';

final class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, this.imageUrl, this.fit, this.height});
  final String? imageUrl;
  final BoxFit? fit;
  final double? height;
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return ColoredBox(
        color: context.general.colorScheme.onPrimaryContainer,
        child: IconWithText(
          title: LocaleKeys.notFound_image.tr(),
          icon: AppIcons.info,
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
      width: context.sized.width,
      height: height,
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: context.general.colorScheme.onPrimaryContainer,
          highlightColor:
              context.general.colorScheme.onPrimaryContainer.withOpacity(0.2),
          child: Container(
            alignment: Alignment.center,
            height: height ?? (WidgetSizes.spacingXxl12 * 2),
            width: context.sized.width,
            color: context.general.colorScheme.secondary,
          ),
        );
      },
    );
  }
}
