import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/general/general_sub_title.dart';
import 'package:vbaseproject/product/widget/size/index.dart';

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
            isBold: true,
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right_outlined,
            size: IconSize.large.value,
          ),
        ],
      ),
    );
  }
}
