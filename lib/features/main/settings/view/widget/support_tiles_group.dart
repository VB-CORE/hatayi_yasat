part of '../settings_view.dart';

/// DESTEK & BİLGİ block — Bize ulaşın / Uygulama hakkında / Uygulamayı
/// değerlendir / Geliştirici ekibi grouped in a V2 bordered card. Reuses
/// the existing destinations (contact bottom sheet, app-about bottom
/// sheet, in-app review, developers route) but surfaces them through
/// V2-styled rows so the page reads consistently with the GENEL/HESAP
/// groups above and below it.
final class _SupportTilesGroup extends StatelessWidget {
  const _SupportTilesGroup();

  @override
  Widget build(BuildContext context) {
    return _V2SettingsGroup(
      children: [
        _V2SettingTile(
          key: const Key('settingsContactTile'),
          icon: Icons.support_agent_rounded,
          label: LocaleKeys.settingsV2_supportRow.tr(),
          onTap: () => _showContactSheet(context),
        ),
        _V2SettingTile(
          key: const Key('settingsAboutTile'),
          icon: Icons.info_outline_rounded,
          label: LocaleKeys.settingsV2_aboutRow.tr(),
          onTap: () => _showAboutSheet(context),
        ),
        _V2SettingTile(
          key: const Key('settingsRateTile'),
          icon: Icons.star_rounded,
          label: LocaleKeys.settingsV2_rateRow.tr(),
          onTap: () => AppReview.instance.openStore(),
        ),
        _V2SettingTile(
          key: const Key('settingsDevelopersTile'),
          icon: Icons.group_rounded,
          label: LocaleKeys.settingsV2_developersRow.tr(),
          isLast: true,
          onTap: () => const DevelopersRoute().push<void>(context),
        ),
      ],
    );
  }

  Future<void> _showContactSheet(BuildContext context) async {
    final colorScheme = context.general.colorScheme;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: colorScheme.secondary,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const EmptyBox.smallHeight(),
              Text(
                LocaleKeys.settings_contactTitle.tr(),
                style: V2Typography.display(
                  fontSize: 22,
                  color: colorScheme.primary,
                ),
              ),
              const EmptyBox.smallHeight(),
              const _ContactUsGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAboutSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (_) => const AppAboutView(),
    );
  }
}
