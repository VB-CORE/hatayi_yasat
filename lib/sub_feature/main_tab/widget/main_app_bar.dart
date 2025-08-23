part of '../main_tab_view.dart';

final class _MainAppBar extends AppBar {
  _MainAppBar({
    required BuildContext context,
  }) : super(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
            child: Divider(
              height: AppConstants.kOne.toDouble(),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () async {
              final result = await RegionalCitySheet.show(context);
              if (result == null) return;
              ProjectDependencyItems.productProvider.saveSelectedCity(result);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: WidgetSizes.spacingXSs,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowDown01,
                  color: context.general.colorScheme.primary,
                ),
                const _AppBarTitle(),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                const NotificationsRoute().go(context);
              },
              icon: const Icon(AppIcons.notifications),
            ),
            IconButton(
              onPressed: () async {
                await const SettingsRoute().push<void>(context);
              },
              icon: const Icon(AppIcons.settings),
            ),
            const _CustomPopupMenu(),
          ],
        );
}

final class _AppBarTitle extends ConsumerWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCity = ref.watch(ProjectDependencyItems.productProviderState);
    return GeneralSubTitle(
      value: currentCity.selectedCity.description,
      fontWeight: FontWeight.bold,
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
