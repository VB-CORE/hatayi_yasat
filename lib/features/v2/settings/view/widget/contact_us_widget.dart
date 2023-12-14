part of '../settings_view.dart';

final class _ContactUsWidget extends StatelessWidget {
  const _ContactUsWidget();

  @override
  Widget build(BuildContext context) {
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_contactTitle.tr(),
      children: const [
        // TODO: yasin
        GeneralBodyTitle('vb10'),
        GeneralBodyTitle('value'),
        GeneralBodyTitle('value'),
      ],
    );
  }
}
