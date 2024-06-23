import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

final class TitleDescription extends StatelessWidget {
  const TitleDescription({
    required this.title,
    required this.description,
    super.key,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.general.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const PagePadding.onlyTopLow(),
            child: Text(
              description,
              style: context.general.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.general.colorScheme.primary.withOpacity(.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
