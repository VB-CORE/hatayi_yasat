import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';

final class IconWithDateTitle extends StatelessWidget {
  const IconWithDateTitle({
    required this.icon,
    required this.dateTime,
    required this.title,
    super.key,
  });
  final IconData icon;
  final DateTime dateTime;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const PagePadding.onlyRightLow(),
          child: Icon(icon),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.general.textTheme.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const PagePadding.onlyTopVeryLow(),
                child: Text(
                  DateFormat.yMMMEd().format(dateTime),
                  style: context.general.textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
