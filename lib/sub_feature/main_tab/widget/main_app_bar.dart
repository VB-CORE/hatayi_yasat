part of '../main_tab_view.dart';

final class _MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _MainAppBar({required this.cities});

  final List<TownModel> cities;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(cityViewModelProvider);
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
        child: Divider(
          height: AppConstants.kOne.toDouble(),
        ),
      ),
      leading: IconButton(
        onPressed: () async {
          /// TODO: Düzenlenmeli
          final selectedItem = await GeneralSelectSheet.show(
            context,
            isDismissible: true,
            mainAxisSize: MainAxisSize.min,
            items: cities
                .map(
                  (city) => SelectSheetModel(
                    id: city.documentId,
                    title: city.displayName,
                  ),
                )
                .toList(),
          );
          if (selectedItem != null) {
            if (context.mounted) unawaited(ChangingDialog.show(context));
            await Future<void>.delayed(Durations.long2);
            ref.read(cityViewModelProvider.notifier).city = cities
                .firstWhere(
                  (city) => selectedItem.id == city.documentId,
                )
                .displayName;
            if (context.mounted) Navigator.of(context).pop();
          }
        },
        icon: const Icon(AppIcons.location),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: GeneralSubTitle(
        value: City.fromSelectedCity(selectedCity),
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
