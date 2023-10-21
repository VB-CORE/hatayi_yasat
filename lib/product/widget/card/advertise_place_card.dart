import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/widget/sheet/advertise_sheet.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class AdvertisePlaceCard extends StatelessWidget {
  const AdvertisePlaceCard({
    required this.item,
    super.key,
  });
  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(WidgetSizes.spacingXSS),
      child: ListTile(
        onTap: () async => AdvertiseSheet.show(context, item: item),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: WidgetSizes.spacingXSs,
        ),
        tileColor: context.general.colorScheme.onInverseSurface,
        dense: true,
        leading: const Icon(Icons.work_history_outlined),
        title: item.title.ext.isNullOrEmpty ? null : _Title(item.title!),
        subtitle: item.role.ext.isNullOrEmpty ? null : _Subtitle(item.role!),
        trailing: const Icon(Icons.chevron_right_outlined),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
