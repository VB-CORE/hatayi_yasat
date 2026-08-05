part of '../settings_view.dart';

@immutable
final class _ChangeLanguageWidget extends StatelessWidget {
  const _ChangeLanguageWidget();

  @override
  Widget build(BuildContext context) {
    return ContentMenu(
      items: [
        ContentMenuItem(
          icon: AppIcons.globe,
          label: LocaleKeys.settings_currentLanguage.tr(context: context),
          showChevron: false,
          trailing: Transform.scale(
            scale: 0.85,
            child: GeneralSegmentedControl<String>(
              value: context.locale.languageCode,
              options: context.supportedLocales
                  .map((locale) => locale.languageCode)
                  .toList(),
              labelBuilder: (code) => code.toUpperCase(),
              onChanged: (code) => _onLanguageChanged(context, code),
            ),
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
