import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

import 'package:lifeclient/product/widget/general/index.dart';

part './item/jobs_card_sheet_item.dart';

@immutable
final class JobsCard extends StatelessWidget {
  const JobsCard({required this.item, super.key});
  final AdvertiseModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (context) => _JobsSheetView(item: item),
          );
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralSubTitle(value: item.title ?? ''),
            const Divider(),
          ],
        ),
        subtitle: Row(
          children: [
            GeneralBodyTitle(
              LocaleKeys.advertise_role.tr(),
            ),
            GeneralBodyTitle(item.role ?? '', fontWeight: FontWeight.bold),
          ],
        ),
        trailing: const Icon(AppIcons.rightArrow),
      ),
    );
  }
}
