part of '../settings_view.dart';

@immutable
final class _ChangeLanguageWidget extends StatelessWidget {
  const _ChangeLanguageWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GeneralGroupSectionHeader(
          label: LocaleKeys.settings_languageTitle
              .tr(context: context)
              .toUpperCase(),
        ),
        Padding(
          padding:
              const PagePadding.horizontalNormalSymmetric() +
              const PagePadding.vertical12Symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralBodyTitle(
                LocaleKeys.settings_currentLanguage.tr(context: context),
              ),
              GeneralSegmentedControl<String>(
                value: context.locale.languageCode,
                options: context.supportedLocales
                    .map((locale) => locale.languageCode)
                    .toList(),
                labelBuilder: (code) => code.toUpperCase(),
                onChanged: (code) => _onLanguageChanged(context, code),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onLanguageChanged(BuildContext context, String code) async {
    final index = context.supportedLocales.ext.indexOrNull(
      (locale) => locale.languageCode == code,
    );
    if (index == null) return;
    await context.setLocale(context.supportedLocales[index]);
  }
}
