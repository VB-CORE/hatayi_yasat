part of '../main_tab_view.dart';

final class _MainAppBar extends AppBar {
  _MainAppBar({
    required BuildContext context,
  }) : super(
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
            child: Divider(
              height: AppConstants.kOne.toDouble(),
            ),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: WidgetSizes.spacingXSs,
          title: Row(
            children: [
              Assets.icons.icApp.image(
                width: WidgetSizes.spacingXxl2,
              ),
              GeneralSubTitle(
                value: LocaleKeys.project_name.tr(context: context),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () async {
                final response = await showSearch<SearchResponse>(
                  context: context,
                  delegate: PlaceSearchDelegate(),
                );

                if (response == null) return;
                if (!context.mounted) return;
                PlaceDetailRoute(
                  $extra: StoreModel.empty(),
                  id: response.id,
                ).go(context);
              },
            ),
            IconButton(
              onPressed: () {
                const NotificationsRoute().go(context);
              },
              icon: const Icon(AppIcons.notifications),
            ),
            const _CustomPopupMenu(),
          ],
        );
}

final class _CustomPopupMenu extends StatelessWidget {
  const _CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: context.general.colorScheme.secondary,
      icon: Icon(
        AppIcons.moreDots,
        color: context.general.colorScheme.primary,
      ),
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return [
          _CustomPopupMenuItem<void>(
            itemLabel: LocaleKeys.specialAgency_title,
            destination: () {
              const SpecialAgencyRoute().go(context);
            },
          ),
          _CustomPopupMenuItem<void>(
            itemLabel: LocaleKeys.favorite_title,
            destination: () {
              const FavoriteRoute().go(context);
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
          onTap: destination,
        );
}
