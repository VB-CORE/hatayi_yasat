part of '../settings_view.dart';

@immutable
final class _AppAboutWidget extends StatelessWidget {
  const _AppAboutWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.superMaxThick),
      child: ListTile(
        contentPadding: const PagePadding.generalAllNormal(),
        title: GeneralBodyTitle(
          LocaleKeys.settings_aboutTitle.tr(),
          fontWeight: FontWeight.bold,
        ),
        trailing: const Icon(AppIcons.rightSelect),
        onTap: () {
          // navigate to AppAboutView
        },
      ),
    );
  }
}
