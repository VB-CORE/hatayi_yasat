import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/widget/icon/icon_with_text.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, this.imageUrl, this.fit});
  final String? imageUrl;
  final BoxFit? fit;
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
    );
  }
}
