import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/core/init/core_localize.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/widget/general/title/index.dart';

final class LanguageDropdownWidget extends StatelessWidget {
  const LanguageDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: context.border.normalBorderRadius,
      onChanged: (value) async => _onChanged(context, value),
      value: context.locale.languageCode,
      decoration: _decoration,
      elevation: 2,
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

  InputDecoration get _decoration => InputDecoration(
        border: _border,
        focusedBorder: _border,
      );

  OutlineInputBorder get _border => const OutlineInputBorder(
        borderSide: BorderSide(strokeAlign: 0.1),
        borderRadius: CustomRadius.large,
      );

  Future<void> _onChanged(BuildContext context, String? value) async {
    final index = context.supportedLocales.ext
        .indexOrNull((locale) => locale.languageCode == value);
    if (index == null) return;
    final locale = context.supportedLocales[index];
    await context.setLocale(locale);
  }
}
