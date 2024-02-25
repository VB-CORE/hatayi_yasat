import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/common/color_common.dart';

import 'package:lifeclient/product/widget/sheet/advertise_sheet.dart';

@immutable
final class AdvertisePlaceCard extends StatelessWidget {
  const AdvertisePlaceCard({
    required this.item,
    super.key,
  });
  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    if (item.title.ext.isNullOrEmpty) return const SizedBox.shrink();

    return InkWell(
      onTap: () => AdvertiseSheet.show(context, item: item),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const PagePadding.allVeryLow(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(item.title!),
              const Divider(),
              if (item.role.ext.isNotNullOrNoEmpty)
                Expanded(child: _Subtitle(item.role!)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

final class _Title extends StatelessWidget {
  const _Title(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

final class _Subtitle extends StatelessWidget {
  const _Subtitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: context.general.textTheme.labelMedium?.copyWith(
        color: ColorCommon(context).whiteAndBlackForTheme,
      ),
    );
  }
}
