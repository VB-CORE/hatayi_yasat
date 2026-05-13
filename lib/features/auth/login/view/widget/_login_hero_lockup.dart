part of '../login_view.dart';

/// Brand lockup at the top of the login hero — logo + wordmark + small
/// teal "Topluluk" chip below the title. Mirrors the V2 jsx
/// `<HyLogo /> <Hatay'ı Yaşat>` row.
final class _LoginHeroLockup extends StatelessWidget {
  const _LoginHeroLockup();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HyLogo(size: 48),
        const EmptyBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.project_name.tr(),
              style: V2Typography.display(
                fontSize: 18,
                // Brand-locked white on navy hero.
                color: ColorsCustom.white,
              ),
            ),
            const EmptyBox(height: 3),
            Text(
              LocaleKeys.auth_communityChip.tr().toUpperCase(),
              style: V2Typography.eyebrow(
                fontSize: 10.5,
                color: ColorsCustom.teal200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
