import 'package:flutter/material.dart';
import 'package:vbaseproject/product/widget/size/index.dart';
import 'package:vbaseproject/product/widget/text/custom_title_text.dart';

final class CustomClickableTitleText extends StatelessWidget {
  const CustomClickableTitleText({
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
          CustomTitleText(title: title),
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
