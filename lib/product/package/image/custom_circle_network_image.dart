import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/icon/icon_with_text.dart';

final class CustomCircleNetworkImage extends StatelessWidget {
  const CustomCircleNetworkImage({
    required this.radius,
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;
  final double radius;

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
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: radius,
      ),
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: context.general.colorScheme.onPrimaryContainer,
          highlightColor:
              context.general.colorScheme.onPrimaryContainer.withOpacity(0.2),
          child: Container(
            alignment: Alignment.center,
            height: radius,
            width: context.sized.dynamicWidth(.1),
            color: context.general.colorScheme.secondary,
          ),
        );
      },
    );
  }
}
