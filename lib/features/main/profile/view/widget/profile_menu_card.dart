part of '../profile_view.dart';

final class ProfileMenuCard extends ConsumerWidget {
  const ProfileMenuCard({
    required this.onAboutPressed,
    required this.onSignOut,
    super.key,
  });

  final VoidCallback onAboutPressed;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCount = ref.watch(
      ProjectDependencyItems.productProviderState.select(
        (state) => state.favoritePlaces.length,
      ),
    );
    final isAuthenticated = ref.watch(
      authViewModelProvider.select((state) => state.isAuthenticated),
    );

    return ContentMenu(
      items: [
        ContentMenuItem(
          icon: AppIcons.favorite,
          label: LocaleKeys.profile_menu_favorites.tr(),
          onTap: () => const FavoriteRoute().push<void>(context),
          trailing: Text(
            '$favoriteCount',
            style: AppText.bodyLg.copyWith(color: AppColors.navy300),
          ),
        ),
        ContentMenuItem(
          icon: AppIcons.settingsFilled,
          label: LocaleKeys.profile_menu_settings.tr(),
          onTap: () => const SettingsRoute().push<void>(context),
        ),
        ContentMenuItem(
          icon: AppIcons.rate,
          label: LocaleKeys.profile_menu_rateUs.tr(),
          onTap: AppReview.instance.openStore,
        ),
        ContentMenuItem(
          icon: AppIcons.privacyFilled,
          label: LocaleKeys.profile_menu_privacy.tr(),
          onTap: () => KvkkCheckBox.navigate(context),
        ),
        ContentMenuItem(
          icon: AppIcons.infoFilled,
          label: LocaleKeys.profile_menu_about.tr(),
          onTap: onAboutPressed,
        ),
        ContentMenuItem(
          icon: AppIcons.code,
          label: LocaleKeys.profile_menu_developers.tr(),
          onTap: () => const DevelopersRoute().push<void>(context),
        ),
        if (isAuthenticated)
          ContentMenuItem(
            icon: AppIcons.exitGroup,
            label: LocaleKeys.profile_menu_signOut.tr(),
            labelColor: AppColors.coral500,
            showChevron: false,
            onTap: onSignOut,
          ),
      ],
    );
  }
}
