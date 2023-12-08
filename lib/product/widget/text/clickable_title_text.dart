import 'package:flutter/material.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/widget/general/title/general_sub_title.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

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
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          GeneralSubTitle(
            value: title,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          Icon(
            AppIcons.rightSelect,
            size: IconSize.large.value,
          ),
        ],
      ),
    );
  }
}
