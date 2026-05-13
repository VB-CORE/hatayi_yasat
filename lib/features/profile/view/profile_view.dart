import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/brand/mosaic_grid.dart';
import 'package:lifeclient/product/widget/circle_avatar/v2_avatar.dart';

part 'widget/_guest_profile_view.dart';

enum MerchantApplicationStatus { none, pending, approved }

/// Profil sekmesi. Esnaf başvuru durumu (yok / bekliyor / onaylı) ekrandaki
/// "Esnaf başvurusu" kartının görünümünü değiştirir.
///
/// Pass `isGuest: true` to render the V2 misafir profili (sınırlı erişim)
/// layout instead — used when the current session is the `'guest'` stub
/// from `_auth_session.dart`.
class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    this.cityId = 'hatay',
    this.merchantStatus = MerchantApplicationStatus.none,
    this.onMerchantTap,
    this.onSettingsTap,
    this.onLogoutTap,
    this.isGuest = false,
  });

  final String cityId;
  final MerchantApplicationStatus merchantStatus;
  final VoidCallback? onMerchantTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    if (isGuest && merchantStatus == MerchantApplicationStatus.none) {
      return const _GuestProfileView();
    }
    final me = V2SampleData.me;
    return ColoredBox(
      color: colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Header(user: me, cityId: cityId),
          const EmptyBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _StatTile(
                  value: '38',
                  label: LocaleKeys.profile_statShares.tr(),
                ),
                const EmptyBox.smallWidth(),
                _StatTile(
                  value: '12',
                  label: LocaleKeys.profile_statFavorites.tr(),
                ),
                const EmptyBox.smallWidth(),
                _StatTile(
                  value: '5',
                  label: LocaleKeys.profile_statMemories.tr(),
                ),
              ],
            ),
          ),
          const EmptyBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Builder(
              builder: (context) => _MerchantCard(
                status: merchantStatus,
                onTap:
                    onMerchantTap ??
                    () => const MerchantOnboardingRoute().push<void>(context),
              ),
            ),
          ),
          const EmptyBox(height: 14),
          _MenuList(
            onSettings: onSettingsTap,
            onLogout: onLogoutTap,
          ),
          const EmptyBox.largeHeight(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user, required this.cityId});

  final V2User user;
  final String cityId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final city = V2SampleData.cityById(cityId);
    return Container(
      // Brand-locked navy hero — V2 keeps the profile header dark in both
      // light and dark theme, so we read raw brand tokens here.
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsCustom.navy, ColorsCustom.navy600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned.fill(child: MosaicGrid(tileSize: 16)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(
                    LocaleKeys.profile_eyebrow.tr(),
                    color: ColorsCustom.coral300,
                  ),
                  const EmptyBox(height: 12),
                  Row(
                    children: [
                      V2Avatar(user: user, size: 64),
                      const EmptyBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: V2Typography.display(
                                fontSize: 24,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              '@${user.handle} · ${city.name}',
                              style: V2Typography.label(
                                fontSize: 12.5,
                                color: colorScheme.onPrimary.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: CustomRadius.large,
          border: Border.all(color: colorScheme.onPrimaryContainer),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: V2Typography.display(
                fontSize: 22,
                color: colorScheme.primary,
              ),
            ),
            Text(
              label,
              style: V2Typography.label(
                fontSize: 11.5,
                color: colorScheme.onSecondaryFixed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MerchantCard extends StatelessWidget {
  const _MerchantCard({required this.status, required this.onTap});

  final MerchantApplicationStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: CustomRadius.large,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: CustomRadius.large,
          border: Border.all(color: colorScheme.onPrimaryContainer),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _iconBg(colorScheme),
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(_icon, color: _iconTint(colorScheme), size: 20),
            ),
            const EmptyBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const EmptyBox.xxSmallHeight(),
                  Text(
                    _body,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryFixedVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSecondaryFixed,
            ),
          ],
        ),
      ),
    );
  }

  String get _title {
    switch (status) {
      case MerchantApplicationStatus.none:
        return LocaleKeys.profile_merchantApplyTitle.tr();
      case MerchantApplicationStatus.pending:
        return LocaleKeys.profile_merchantPendingTitle.tr();
      case MerchantApplicationStatus.approved:
        return LocaleKeys.profile_merchantApprovedTitle.tr();
    }
  }

  String get _body {
    switch (status) {
      case MerchantApplicationStatus.none:
        return LocaleKeys.profile_merchantApplyBody.tr();
      case MerchantApplicationStatus.pending:
        return LocaleKeys.profile_merchantPendingBody.tr();
      case MerchantApplicationStatus.approved:
        return LocaleKeys.profile_merchantApprovedBody.tr();
    }
  }

  IconData get _icon {
    switch (status) {
      case MerchantApplicationStatus.none:
        return Icons.storefront_rounded;
      case MerchantApplicationStatus.pending:
        return Icons.hourglass_empty_rounded;
      case MerchantApplicationStatus.approved:
        return Icons.verified_rounded;
    }
  }

  Color _iconTint(ColorScheme colorScheme) {
    switch (status) {
      case MerchantApplicationStatus.none:
        return colorScheme.primary;
      case MerchantApplicationStatus.pending:
        return colorScheme.tertiary;
      case MerchantApplicationStatus.approved:
        return colorScheme.primaryContainer;
    }
  }

  Color _iconBg(ColorScheme colorScheme) {
    switch (status) {
      case MerchantApplicationStatus.none:
        return colorScheme.onPrimaryFixed;
      case MerchantApplicationStatus.pending:
        return colorScheme.tertiaryContainer;
      case MerchantApplicationStatus.approved:
        return colorScheme.primaryContainer.withValues(alpha: 0.18);
    }
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList({required this.onSettings, required this.onLogout});

  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        border: Border.all(color: colorScheme.onPrimaryContainer),
      ),
      child: Column(
        children: [
          _MenuItem(
            icon: Icons.settings_rounded,
            label: LocaleKeys.profile_menuSettings.tr(),
            onTap: onSettings,
          ),
          _MenuItem(
            icon: Icons.help_outline_rounded,
            label: LocaleKeys.profile_menuHelp.tr(),
            onTap: () {},
          ),
          _MenuItem(
            icon: Icons.privacy_tip_outlined,
            label: LocaleKeys.profile_menuPrivacy.tr(),
            onTap: () {},
          ),
          _MenuItem(
            icon: Icons.logout_rounded,
            label: LocaleKeys.profile_menuLogout.tr(),
            tint: colorScheme.error,
            onTap: onLogout,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.tint,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? tint;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final color = tint ?? colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const EmptyBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: tint ?? colorScheme.onSecondaryFixed,
                  ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                height: 1,
                thickness: 1,
                color: colorScheme.onPrimaryContainer,
              ),
          ],
        ),
      ),
    );
  }
}
