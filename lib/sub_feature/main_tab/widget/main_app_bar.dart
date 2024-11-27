part of '../main_tab_view.dart';

final class _MainAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const _MainAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

final class _MainAppBarState extends ConsumerState<_MainAppBar>
    with MainAppBarMixin<_MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
        child: Divider(
          height: AppConstants.kOne.toDouble(),
        ),
      ),
      leading: IconButton(
        onPressed: () => handleCitySelection(context),
        icon: const Icon(AppIcons.location),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: GeneralSubTitle(
        value: City.fromSelectedCity(cityState.selectedCity),
        fontWeight: FontWeight.bold,
      ),
      actions: [
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
}

final class _CustomPopupMenu extends StatelessWidget {
  const _CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 0,
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
              const FavoriteRoute().push<void>(context);
            },
          ),
          _CustomPopupMenuItem<void>(
            itemLabel: LocaleKeys.chain_stores_title,
            destination: () {
              const ChainStoresRoute().go(context);
            },
          ),
          _CustomPopupMenuItem<void>(
            itemLabel: LocaleKeys.tourismView_title,
            destination: () {
              const TurismRoute().go(context);
            },
          ),
          _CustomPopupMenuItem<void>(
            itemLabel: LocaleKeys.usefulLink_title,
            destination: () {
              const UsefulLinksRoute().go(context);
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
