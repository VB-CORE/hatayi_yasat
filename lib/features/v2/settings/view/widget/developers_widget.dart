part of '../settings_view.dart';

@immutable
final class _DevelopersWidget extends StatelessWidget {
  const _DevelopersWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.superMaxThick),
      child: ListTile(
        title: GeneralContentTitle(
          value: LocaleKeys.developers_title.tr(),
          fontWeight: FontWeight.bold,
        ),
        subtitle: GeneralContentSubTitle(
          value: LocaleKeys.settings_seeDevelopers.tr(),
        ),
        contentPadding: const PagePadding.generalAllNormal(),
        leading: const Icon(
          AppIcons.group,
          size: WidgetSizes.spacingXxl6,
        ),
        trailing: const Icon(AppIcons.rightSelect),
        onTap: () => const DevelopersRoute().push<DevelopersRoute>(context),
      ),
    );
  }
}
