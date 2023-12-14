part of '../settings_view.dart';

final class _ChangeLanguageWidget extends StatelessWidget {
  const _ChangeLanguageWidget();

  @override
  Widget build(BuildContext context) {
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_languageTitle.tr(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GeneralBodyTitle(LocaleKeys.settings_currentLanguage.tr()),
            const LanguageChangeWidget(),
          ],
        ),
      ],
    );
  }
}
