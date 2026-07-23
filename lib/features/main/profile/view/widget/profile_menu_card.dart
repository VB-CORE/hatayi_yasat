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

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.navy50),
        boxShadow: AppShadows.card,
      ),
      padding: const PagePadding.allLow(),
      child: Column(
        children: [
          _ProfileMenuRow(
            icon: AppIcons.favorite,
            label: LocaleKeys.profile_menu_favorites.tr(),
            onTap: () => const FavoriteRoute().push<void>(context),
            trailing: Text(
              '$favoriteCount',
              style: AppText.bodyLg.copyWith(color: AppColors.navy300),
            ),
          ),
          const Divider(color: AppColors.navy50),
          _ProfileMenuRow(
            icon: AppIcons.settings,
            label: LocaleKeys.profile_menu_settings.tr(),
            onTap: () => const SettingsRoute().push<void>(context),
          ),
          const Divider(color: AppColors.navy50),
          _ProfileMenuRow(
            icon: AppIcons.rate,
            label: LocaleKeys.profile_menu_rateUs.tr(),
            onTap: AppReview.instance.openStore,
          ),
          const Divider(color: AppColors.navy50),
          _ProfileMenuRow(
            icon: AppIcons.privacyFilled,
            label: LocaleKeys.profile_menu_privacy.tr(),
            onTap: () => KvkkCheckBox.navigate(context),
          ),
          const Divider(color: AppColors.navy50),
          _ProfileMenuRow(
            icon: AppIcons.infoFilled,
            label: LocaleKeys.profile_menu_about.tr(),
            onTap: onAboutPressed,
          ),
          const Divider(color: AppColors.navy50),
          _ProfileMenuRow(
            icon: AppIcons.code,
            label: LocaleKeys.profile_menu_developers.tr(),
            onTap: () => const DevelopersRoute().push<void>(context),
          ),
          AuthSwitcher(
            authorized: Column(
              children: [
                const Divider(color: AppColors.navy50),
                _ProfileMenuRow(
                  icon: AppIcons.exitGroup,
                  label: LocaleKeys.profile_menu_signOut.tr(),
                  labelColor: AppColors.coral500,
                  showChevron: false,
                  onTap: onSignOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _ProfileMenuRow extends StatelessWidget {
  const _ProfileMenuRow({
    required this.icon,
    required this.label,
    this.trailing,
    this.labelColor,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final Color? labelColor;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomBounceable(
      onTap: onTap,
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.coral50,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            padding: const PagePadding.allLow(),
            child: Icon(
              icon,
              size: AppIconSizes.medium,
              color: AppColors.coral500,
            ),
          ),
          Text(label, style: AppText.bodyLg.copyWith(color: labelColor)),
          const Spacer(),
          ?trailing,
          if (showChevron)
            const Icon(
              AppIcons.rightSelect,
              size: AppIconSizes.medium,
              color: AppColors.navy300,
            ),
        ],
      ),
    );
  }
}
