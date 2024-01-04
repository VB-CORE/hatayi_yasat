part of '../settings_view.dart';

@immutable
final class _ChangeLanguageWidget extends StatelessWidget {
  const _ChangeLanguageWidget();

  @override
  Widget build(BuildContext context) {
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_languageTitle,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GeneralBodyTitle(
              LocaleKeys.settings_currentLanguage.tr(
                context: context,
              ),
            ),
            const IntrinsicWidth(child: LanguageDropdownWidget()),
          ],
        ),
        const EmptyBox.middleHeight(),
      ],
    );
  }
}
