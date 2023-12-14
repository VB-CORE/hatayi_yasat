import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/core/init/core_localize.dart';
import 'package:vbaseproject/product/widget/general/title/index.dart';

final class LanguageDropdownWidget extends StatelessWidget {
  const LanguageDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (value) async => _onChanged(context, value),
      value: context.locale.languageCode,
      items: AppLocale.values
          .map<DropdownMenuItem<String>>(
            (AppLocale value) => DropdownMenuItem(
              value: value.name,
              child: GeneralBodyTitle(value.name.toUpperCase()),
            ),
          )
          .toList(),
    );
  }

  Future<void> _onChanged(BuildContext context, String? value) async {
    final index = context.supportedLocales.ext
        .indexOrNull((locale) => locale.languageCode == value);
    if (index == null) return;
    final locale = context.supportedLocales[index];
    await context.setLocale(locale);
  }
}
