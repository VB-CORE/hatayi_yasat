import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class WhatsNewSheet extends StatelessWidget {
  const WhatsNewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const PagePadding.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralBodyTitle(LocaleKeys.whatsNew_title.tr()),
              const Divider(),
              Text(LocaleKeys.whatsNew_homeView.tr()),
              const EmptyBox.largeHeight(),
            ],
          ),
        ),
      ),
    );
  }
}
