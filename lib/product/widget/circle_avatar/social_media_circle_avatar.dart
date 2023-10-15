import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';

class SocialMediaCircleAvatar extends StatelessWidget {
  const SocialMediaCircleAvatar({
    required this.iconData,
    required this.webUrl,
    super.key,
  });

  final IconData iconData;
  final String webUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => webUrl.ext.launchWebsite,
      child: CircleAvatar(
        backgroundColor: context.general.colorScheme.secondary,
        child: FaIcon(
          iconData,
          color: ColorCommon(context).blackAndWhiteForTheme,
        ),
      ),
    );
  }
}
