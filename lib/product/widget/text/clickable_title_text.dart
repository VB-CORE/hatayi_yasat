import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/widget/general/title/general_sub_title.dart';
import 'package:lifeclient/product/widget/tap_area/tap_area.dart';

@immutable
final class ClickableSubTitleText extends StatelessWidget {
  const ClickableSubTitleText({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapArea(
      onTap: onTap,
      child: Row(
        children: [
          GeneralSubTitle(
            value: title,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          const Icon(
            AppIcons.rightSelect,
          ),
        ],
      ),
    );
  }
}
