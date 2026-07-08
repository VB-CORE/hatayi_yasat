part of '../main_tab_view.dart';

final class _MainAppBar extends AppBar {
  _MainAppBar() : super(
         bottom: PreferredSize(
           preferredSize: const Size.fromHeight(WidgetSizes.spacingS),
           child: Divider(
             height: AppConstants.kOne.toDouble(),
           ),
         ),
         automaticallyImplyLeading: false,
         centerTitle: false,
         titleSpacing: AppSpacing.lg,
         title: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             Assets.icons.icAppTransparent.image(
               height: WidgetSizes.spacingXxl,
               width: WidgetSizes.spacingXxl,
             ),
             const SizedBox(width: AppSpacing.sm),
             const _CityPill(),
           ],
         ),
         actions: const [
           _NotificationButton(),
           _SettingsButton(),
           _CustomPopupMenu(),
           SizedBox(width: AppSpacing.xxs),
         ],
       );
}

final class _CityPill extends ConsumerWidget {
  const _CityPill();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCity = ref.watch(ProjectDependencyItems.productProviderState);
    return Material(
      color: AppColors.coral50,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: () async {
          final result = await RegionalCitySheet.show(context);
          if (result == null) return;
          ProjectDependencyItems.productProvider.saveSelectedCity(result);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                AppIcons.location,
                size: WidgetSizes.spacingMx,
                color: AppColors.coral,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                currentCity.selectedCity.description,
                style: AppText.label.copyWith(color: AppColors.coral700),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: WidgetSizes.spacingL,
                color: AppColors.coral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: () {
            const NotificationsRoute().go(context);
          },
          icon: const Icon(AppIcons.notifications),
        ),
        Positioned(
          top: WidgetSizes.spacingS,
          right: WidgetSizes.spacingS,
          child: Container(
            width: WidgetSizes.spacingXs,
            height: WidgetSizes.spacingXs,
            decoration: BoxDecoration(
              color: AppColors.coral,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

final class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await const SettingsRoute().push<void>(context);
      },
      icon: const Icon(AppIcons.settings),
    );
  }
}

final class _CustomPopupMenu extends StatelessWidget {
  const _CustomPopupMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 0,
      icon: Icon(
        AppIcons.moreDots,
        color: context.general.colorScheme.primary,
      ),
      onSelected: (value) {},
      itemBuilder: (context) {
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
