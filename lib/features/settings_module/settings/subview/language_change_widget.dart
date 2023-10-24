import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/product/widget/size/widget_size.dart';

class LanguageChangeWidget extends StatefulWidget {
  const LanguageChangeWidget({super.key});

  @override
  State<LanguageChangeWidget> createState() => _LanguageChangeWidgetState();
}

class _LanguageChangeWidgetState extends State<LanguageChangeWidget> {
  final String _slashSeparator = ' / ';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSizes.spacingXl,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: context.supportedLocales.length,
        itemBuilder: (context, index) =>
            _LangButton(locale: context.supportedLocales[index]),
        separatorBuilder: (context, index) => Text(
          _slashSeparator,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: ColorCommon(context).whiteAndBlackForTheme,
          ),
        ),
      ),
    );
  }
}

class _LangButton extends StatelessWidget {
  const _LangButton({
    required this.locale,
  });
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (context.locale.languageCode == locale.languageCode) return;
        await context.setLocale(locale);
      },
      child: Text(
        locale.languageCode.toUpperCase(),
        style: context.general.textTheme.titleSmall?.copyWith(
          decoration:
              context.locale == locale ? TextDecoration.underline : null,
          color: ColorCommon(context).whiteAndBlackForTheme,
        ),
      ),
    );
  }
}
