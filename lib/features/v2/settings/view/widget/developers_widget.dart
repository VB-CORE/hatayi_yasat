part of '../settings_view.dart';

final class _DevelopersWidget extends StatelessWidget {
  const _DevelopersWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: const BorderSide()),
      child: ListTile(
        title: GeneralContentTitle(
          value: LocaleKeys.developers_title.tr(),
          fontWeight: FontWeight.bold,
        ),
        subtitle: const GeneralContentSubTitle(
          value: LocaleKeys.settings_seeDevelopers,
        ),
        contentPadding: const PagePadding.generalAllNormal(),
        leading: const Icon(
          Icons.groups_2_outlined,
          size: WidgetSizes.spacingXxl6,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.route.navigateToPage(const DevelopersView()),
      ),
    );
  }
}
