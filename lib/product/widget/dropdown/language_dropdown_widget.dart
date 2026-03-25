import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/init/core_localize.dart';
import 'package:lifeclient/product/utility/decorations/custom_border_side.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/general/title/index.dart';

final class LanguageDropdownWidget extends StatelessWidget {
  const LanguageDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      key: ValueKey(context.locale.languageCode),
      borderRadius: context.border.normalBorderRadius,
      onChanged: (value) async => _onChanged(context, value),
      initialValue: context.locale.languageCode,
      dropdownColor: context.general.colorScheme.secondary,
      iconEnabledColor: context.general.colorScheme.primary,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: context.general.colorScheme.onSurface,
      ),
      decoration: _decoration(context),
      elevation: 2,
      items: AppLocale.values
          .map<DropdownMenuItem<String>>(
            (value) => DropdownMenuItem(
              value: value.name,
              child: GeneralBodyTitle(value.name.toUpperCase()),
            ),
          )
          .toList(),
    );
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
    contentPadding: const PagePadding.horizontalLowSymmetric(),
    filled: true,
    fillColor: context.general.colorScheme.onPrimaryFixed,
    border: _border(
      color: context.general.colorScheme.onPrimaryContainer,
    ),
    enabledBorder: _border(
      color: context.general.colorScheme.onPrimaryContainer,
    ),
    focusedBorder: _border(
      color: context.general.colorScheme.primary,
    ),
  );

  OutlineInputBorder _border({required Color color}) => OutlineInputBorder(
    borderSide: CustomBorderSides.ultraThin.copyWith(color: color),
    borderRadius: CustomRadius.large,
  );

  Future<void> _onChanged(BuildContext context, String? value) async {
    final index = context.supportedLocales.ext.indexOrNull(
      (locale) => locale.languageCode == value,
    );
    if (index == null) return;
    final locale = context.supportedLocales[index];
    await context.setLocale(locale);
  }
}
