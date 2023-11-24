import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

final class CustomTitleText extends StatelessWidget {
  const CustomTitleText({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical8Symmetric(),
      child: Text(
        title,
        style: context.general.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
