import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/size/widget_size.dart';

class LanguageChangeWidget extends StatefulWidget {
  const LanguageChangeWidget({super.key});

  @override
  State<LanguageChangeWidget> createState() => _LanguageChangeWidgetState();
}

class _LanguageChangeWidgetState extends State<LanguageChangeWidget> {
  final String _slashSeperator = ' / ';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSizes.spacingXl,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: context.supportedLocales.length,
        itemBuilder: (context, index) => _textButton(
          context,
          context.supportedLocales[index],
        ),
        separatorBuilder: (context, index) => _text(context, _slashSeperator),
      ),
    );
  }

  InkWell _textButton(BuildContext context, Locale locale) {
    return InkWell(
      onTap: () async {
        if (context.locale.languageCode == locale.languageCode) return;
        await context.setLocale(locale);
      },
      child: _text(context, locale.languageCode),
    );
  }

  Text _text(BuildContext context, String locale) => Text(
        locale.toUpperCase(),
        style: context.general.textTheme.titleSmall?.copyWith(
          decoration: context.locale.languageCode == locale
              ? TextDecoration.underline
              : null,
        ),
      );
}
