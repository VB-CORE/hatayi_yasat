part of '../profile_view.dart';

/// V2 misafir profili. Navy hero + 4 feature-lock cards on the surface
/// body. Login CTA pushes [LoginRoute].
final class _GuestProfileView extends StatelessWidget {
  const _GuestProfileView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return ColoredBox(
      color: colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _GuestHero(),
          const EmptyBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
              children: const [
                _GuestFeatureCard(
                  icon: Icons.favorite_rounded,
                  titleKey: LocaleKeys.auth_guestFeatureLikeTitle,
                  bodyKey: LocaleKeys.auth_guestFeatureLikeBody,
                  accentRole: _FeatureAccent.error,
                ),
                _GuestFeatureCard(
                  icon: Icons.bookmark_rounded,
                  titleKey: LocaleKeys.auth_guestFeatureFavoriteTitle,
                  bodyKey: LocaleKeys.auth_guestFeatureFavoriteBody,
                  accentRole: _FeatureAccent.primary,
                ),
                _GuestFeatureCard(
                  icon: Icons.edit_rounded,
                  titleKey: LocaleKeys.auth_guestFeatureShareTitle,
                  bodyKey: LocaleKeys.auth_guestFeatureShareBody,
                  accentRole: _FeatureAccent.teal,
                ),
                _GuestFeatureCard(
                  icon: Icons.storefront_rounded,
                  titleKey: LocaleKeys.auth_guestFeatureMerchantTitle,
                  bodyKey: LocaleKeys.auth_guestFeatureMerchantBody,
                  accentRole: _FeatureAccent.gold,
                ),
              ],
            ),
          ),
          const EmptyBox.largeHeight(),
        ],
      ),
    );
  }
}

final class _GuestHero extends StatelessWidget {
  const _GuestHero();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Container(
      decoration: const BoxDecoration(
        // Brand-locked navy hero gradient — V2 keeps the guest hero
        // dark in both light and dark theme.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorsCustom.navy, ColorsCustom.navy600],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned.fill(child: MosaicGrid(tileSize: 16)),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(
                    LocaleKeys.auth_guestEyebrow.tr(),
                    // Brand-locked coral eyebrow on the navy hero.
                    color: ColorsCustom.coral300,
                  ),
                  const EmptyBox(height: 12),
                  Text(
                    LocaleKeys.auth_guestTitle.tr(),
                    style: V2Typography.display(
                      fontSize: 30,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const EmptyBox(height: 12),
                  Text(
                    LocaleKeys.auth_guestHeroBody.tr(),
                    style: context.general.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.5,
                      height: 1.55,
                      // Brand-locked white@70 on navy hero.
                      color: ColorsCustom.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const EmptyBox(height: 18),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      key: const Key('guestProfileLoginButton'),
                      onPressed: () => const LoginRoute().push<void>(context),
                      icon: Icon(
                        Icons.login_rounded,
                        size: 18,
                        color: colorScheme.onPrimary,
                      ),
                      label: Text(
                        LocaleKeys.auth_guestHeroCta.tr(),
                        style: V2Typography.label(
                          fontSize: 14.5,
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: CustomRadius.medium,
                        ),
                      ),
                    ),
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

enum _FeatureAccent { error, primary, teal, gold }

final class _GuestFeatureCard extends StatelessWidget {
  const _GuestFeatureCard({
    required this.icon,
    required this.titleKey,
    required this.bodyKey,
    required this.accentRole,
  });

  final IconData icon;
  final String titleKey;
  final String bodyKey;
  final _FeatureAccent accentRole;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final accent = switch (accentRole) {
      _FeatureAccent.error => colorScheme.error,
      _FeatureAccent.primary => colorScheme.primary,
      _FeatureAccent.teal => colorScheme.onSecondaryContainer,
      _FeatureAccent.gold => colorScheme.tertiary,
    };
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        border: Border.all(color: colorScheme.onPrimaryContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: CustomRadius.medium,
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const Spacer(),
              Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: colorScheme.onSecondaryFixed,
              ),
            ],
          ),
          const EmptyBox(height: 10),
          Text(
            titleKey.tr(),
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const EmptyBox.xxSmallHeight(),
          Expanded(
            child: Text(
              bodyKey.tr(),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimaryFixedVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
