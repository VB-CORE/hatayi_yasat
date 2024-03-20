import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class WhatsNewSheet extends StatelessWidget {
  const WhatsNewSheet({super.key});

  static const _newVersionChanges = [
    LocaleKeys.whatsNew_advertiseBannerView,
    LocaleKeys.whatsNew_homeView,
    LocaleKeys.whatsNew_chainView,
    LocaleKeys.whatsNew_notificationViewLink,
    LocaleKeys.whatsNew_bugFixes,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralBodyTitle(
              LocaleKeys.whatsNew_title.tr(),
              fontWeight: FontWeight.w700,
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: _newVersionChanges.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const EmptyBox.smallHeight();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Text(_newVersionChanges[index].tr());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
