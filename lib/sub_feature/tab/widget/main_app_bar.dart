part of '../main_tab_view.dart';

final class _MainAppBar extends AppBar {
  _MainAppBar({
    required BuildContext context,
    super.key,
  }) : super(
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
            child: Divider(
              height: AppConstants.kOne.toDouble(),
            ),
          ),
          title: GeneralSubTitle(
            value: LocaleKeys.project_name.tr(context: context),
            fontWeight: FontWeight.bold,
          ),
          actions: [
            const _CustomPopupMenu(),
          ],
        );
}

final class _CustomPopupMenu extends StatelessWidget {
  const _CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        AppIcons.moreDots,
        color: context.general.colorScheme.primary,
      ),
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.specialAgency_title,
            destination: () {
              // const SpecialAgencyRoute().push<SpecialAgencyRoute>(context);
            },
          ),
          _CustomPopupMenuItem(
            itemLabel: LocaleKeys.favorite_title,
            destination: () {
              // const FavoriteRoute().push<FavoriteRoute>(context);
            },
          ),
        ];
      },
    );
  }
}

final class _CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  _CustomPopupMenuItem({
    required String itemLabel,
    required VoidCallback destination,
  }) : super(
          child: GeneralContentSubTitle(
            value: itemLabel.tr(),
            fontWeight: FontWeight.bold,
          ),
          onTap: () => destination,
        );
}
