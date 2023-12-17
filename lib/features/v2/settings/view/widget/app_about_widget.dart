part of '../settings_view.dart';

final class _AppAboutWidget extends StatelessWidget {
  const _AppAboutWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: const BorderSide()),
      child: ListTile(
        contentPadding: const PagePadding.generalAllNormal(),
        title: GeneralBodyTitle(
          LocaleKeys.settings_aboutTitle.tr(),
          fontWeight: FontWeight.bold,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
