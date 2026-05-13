part of '../settings_view.dart';

/// V2 navy auth-prompt card shown at the top of Settings for guest users.
/// Pushes the user toward the sign-in flow. While FirebaseAuth is still
/// stubbed (see `_auth_session.dart`), this card is always rendered.
/// Once auth lands, gate the visibility on `currentUid == 'guest'`.
final class _AuthPromptWidget extends StatelessWidget {
  const _AuthPromptWidget();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Material(
        // Brand-locked navy CTA card — keeps the mozaik identity in both
        // light & dark modes (matches the LoginView surface).
        color: ColorsCustom.navy,
        borderRadius: CustomRadius.large,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const Key('settingsAuthPromptCard'),
          onTap: () => const LoginRoute().push<void>(context),
          borderRadius: CustomRadius.large,
          child: Stack(
            children: [
              const Positioned.fill(
                child: MosaicGrid(tileSize: 14, opacity: 0.18),
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x00000000),
                        Color(0x33000000),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0x1FFFFFFF),
                            borderRadius: CustomRadius.medium,
                            border: Border.all(
                              color: const Color(0x33FFFFFF),
                            ),
                          ),
                          child: const Icon(
                            Icons.lock_person_rounded,
                            size: 22,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        const EmptyBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Eyebrow(
                                LocaleKeys.settingsV2_authPromptEyebrow.tr(),
                                color: ColorsCustom.coral300,
                              ),
                              const EmptyBox.xSmallHeight(),
                              Text(
                                LocaleKeys.settingsV2_authPromptTitle.tr(),
                                style: V2Typography.display(
                                  fontSize: 18,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const EmptyBox.smallHeight(),
                    Text(
                      LocaleKeys.settingsV2_authPromptBody.tr(),
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12.5,
                        height: 1.5,
                        color: const Color(0xC4FFFFFF),
                      ),
                    ),
                    const EmptyBox.middleHeight(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: CustomRadius.medium,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login_rounded,
                            size: 17,
                            color: colorScheme.primary,
                          ),
                          const EmptyBox(width: 8),
                          Text(
                            LocaleKeys.settingsV2_authPromptCta.tr(),
                            style: textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorsCustom.navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const EmptyBox.xSmallHeight(),
                    Center(
                      child: Text(
                        LocaleKeys.settingsV2_authPromptTagline.tr(),
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xB0FFFFFF),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// HESAP section grouped tiles — Profili düzenle / Gizlilik / Hesabı sil.
/// "Hesabı sil" pops the keyword-gated `showV2DeleteAccountDialog`;
/// "Profili düzenle" surfaces a "yakında" snackbar until the profile
/// editor screen lands.
final class _AccountTilesGroup extends StatelessWidget {
  const _AccountTilesGroup();

  @override
  Widget build(BuildContext context) {
    return _V2SettingsGroup(
      children: [
        _V2SettingTile(
          key: const Key('settingsEditProfileTile'),
          icon: Icons.person_rounded,
          label: LocaleKeys.settingsV2_editProfileRow.tr(),
          onTap: () => _showComingSoon(context),
        ),
        _V2SettingTile(
          key: const Key('settingsPrivacyTile'),
          icon: Icons.shield_rounded,
          label: LocaleKeys.settingsV2_privacyRow.tr(),
          onTap: () => _showComingSoon(context),
        ),
        _V2SettingTile(
          key: const Key('settingsDeleteAccountTile'),
          icon: Icons.delete_forever_rounded,
          label: LocaleKeys.settingsV2_deleteAccountRow.tr(),
          destructive: true,
          isLast: true,
          onTap: () => showV2DeleteAccountDialog(context),
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primary,
        content: Text(
          LocaleKeys.settingsV2_comingSoonMessage.tr(),
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// V2 sign-out row, surfaced near the bottom of Settings. Opens the V2
/// logout bottom sheet; while FirebaseAuth is stubbed (see
/// `_auth_session.dart`) confirming pops a snackbar — once auth ships,
/// wire the `true` branch to the actual sign-out call.
final class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Material(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        child: InkWell(
          key: const Key('settingsSignOutTile'),
          onTap: () => _onTap(context),
          borderRadius: CustomRadius.large,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: CustomRadius.large,
              border: Border.all(color: colorScheme.onPrimaryContainer),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.error.withValues(alpha: 0.10),
                    borderRadius: CustomRadius.medium,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: colorScheme.error,
                  ),
                ),
                const EmptyBox(width: 14),
                Expanded(
                  child: Text(
                    LocaleKeys.settingsV2_signOutRow.tr(),
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.error,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSecondaryFixed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final confirmed = await showV2LogoutDialog(context);
    if (!confirmed || !context.mounted) return;
    final colorScheme = context.general.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorScheme.primary,
        content: Text(
          LocaleKeys.settingsV2_signOutSoonMessage.tr(),
          style: context.general.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Small V2 uppercase section label rendered above each settings group.
final class _SettingsSectionLabel extends StatelessWidget {
  const _SettingsSectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Eyebrow(
        label,
        color: context.general.colorScheme.onSecondaryFixed,
      ),
    );
  }
}
