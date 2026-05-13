part of '../settings_view.dart';

/// V2 GENEL block — Bildirimler / Dil / Görünüm / Engellenenler grouped
/// in a single bordered card. Each row uses [_V2SettingTile] and opens a
/// dedicated V2 bottom sheet (notification settings hint, language
/// picker, theme picker) or a "yakında" snackbar for the blocked-users
/// placeholder.
final class _GeneralTilesGroup extends ConsumerStatefulWidget {
  const _GeneralTilesGroup();

  @override
  ConsumerState<_GeneralTilesGroup> createState() => _GeneralTilesGroupState();
}

class _GeneralTilesGroupState extends ConsumerState<_GeneralTilesGroup> {
  PermissionStatus? _notifStatus;

  @override
  void initState() {
    super.initState();
    unawaited(_refreshNotifStatus());
  }

  Future<void> _refreshNotifStatus() async {
    final status = await Permission.notification.status;
    if (!mounted) return;
    setState(() => _notifStatus = status);
  }

  bool get _isNotifGranted {
    final s = _notifStatus;
    return s == PermissionStatus.granted || s == PermissionStatus.limited;
  }

  String _languageLabel(BuildContext context) {
    final code = context.locale.languageCode;
    return switch (code) {
      'tr' => LocaleKeys.settingsV2_languageTr.tr(),
      'en' => LocaleKeys.settingsV2_languageEn.tr(),
      _ => code.toUpperCase(),
    };
  }

  String _themeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.light => LocaleKeys.settings_themes_light.tr(),
    ThemeMode.dark => LocaleKeys.settings_themes_dark.tr(),
    ThemeMode.system => LocaleKeys.settings_themes_system.tr(),
  };

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ProjectDependencyItems.appProviderState).theme;
    final notifValue = _isNotifGranted
        ? LocaleKeys.settingsV2_valueOn.tr()
        : LocaleKeys.settingsV2_valueOff.tr();

    return _V2SettingsGroup(
      children: [
        _V2SettingTile(
          key: const Key('settingsNotifTile'),
          icon: Icons.notifications_rounded,
          label: LocaleKeys.settingsV2_notificationsRow.tr(),
          value: notifValue,
          onTap: () async {
            await _showV2NotifSheet(context);
            await _refreshNotifStatus();
          },
        ),
        _V2SettingTile(
          key: const Key('settingsLanguageTile'),
          icon: Icons.language_rounded,
          label: LocaleKeys.settings_languageTitle.tr(),
          value: _languageLabel(context),
          onTap: () => _showV2LanguageSheet(context),
        ),
        _V2SettingTile(
          key: const Key('settingsThemeTile'),
          icon: Icons.dark_mode_rounded,
          label: LocaleKeys.settingsV2_themeSheetTitle.tr(),
          value: _themeLabel(theme),
          onTap: () => _showV2ThemeSheet(context, ref),
        ),
        _V2SettingTile(
          key: const Key('settingsBlockedTile'),
          icon: Icons.block_rounded,
          label: LocaleKeys.settingsV2_blockedRow.tr(),
          isLast: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: context.general.colorScheme.primary,
                content: Text(
                  LocaleKeys.settingsV2_comingSoonMessage.tr(),
                  style: context.general.textTheme.bodyMedium?.copyWith(
                    color: context.general.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Notification settings hint sheet. Permission flips have to happen in
/// the OS settings, so the sheet explains why and ships a CTA to jump
/// straight into the iOS / Android notification preferences screen.
Future<void> _showV2NotifSheet(BuildContext context) async {
  final colorScheme = context.general.colorScheme;
  final textTheme = context.general.textTheme;
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
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
            const EmptyBox.middleHeight(),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.10),
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(
                Icons.notifications_active_rounded,
                color: colorScheme.error,
                size: 24,
              ),
            ),
            const EmptyBox.smallHeight(),
            Text(
              LocaleKeys.settingsV2_notifSheetTitle.tr(),
              style: V2Typography.display(
                fontSize: 22,
                color: colorScheme.onSurface,
              ),
            ),
            const EmptyBox.xSmallHeight(),
            Text(
              LocaleKeys.settingsV2_notifSheetBody.tr(),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryFixed,
                height: 1.5,
              ),
            ),
            const EmptyBox.middleHeight(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  CustomAppSettings.open(
                    type: CustomAppSettingsType.notification,
                  );
                },
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                label: Text(LocaleKeys.settingsV2_notifSheetOpen.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: CustomRadius.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Language picker sheet — radio list of every supported locale.
Future<void> _showV2LanguageSheet(BuildContext context) async {
  final colorScheme = context.general.colorScheme;
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => _V2SheetScaffold(
      title: LocaleKeys.settingsV2_languageSheetTitle.tr(),
      children: [
        for (final locale in AppLocale.values)
          _V2RadioRow(
            label: switch (locale) {
              AppLocale.tr => LocaleKeys.settingsV2_languageTr.tr(),
              AppLocale.en => LocaleKeys.settingsV2_languageEn.tr(),
            },
            isActive: context.locale.languageCode == locale.locale.languageCode,
            onTap: () async {
              Navigator.of(sheetContext).pop();
              await context.setLocale(locale.locale);
            },
          ),
      ],
    ),
  );
}

/// Theme picker sheet — radio list of `ThemeMode.values`. Tapping a row
/// hands off to `AppProvider.changeAppTheme` and pops the sheet.
Future<void> _showV2ThemeSheet(BuildContext context, WidgetRef ref) async {
  final colorScheme = context.general.colorScheme;
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => Consumer(
      builder: (consumerContext, consumerRef, _) {
        final current = consumerRef
            .watch(ProjectDependencyItems.appProviderState)
            .theme;
        return _V2SheetScaffold(
          title: LocaleKeys.settingsV2_themeSheetTitle.tr(),
          children: [
            for (final mode in ThemeMode.values)
              _V2RadioRow(
                label: switch (mode) {
                  ThemeMode.light => LocaleKeys.settings_themes_light.tr(),
                  ThemeMode.dark => LocaleKeys.settings_themes_dark.tr(),
                  ThemeMode.system => LocaleKeys.settings_themes_system.tr(),
                },
                isActive: current == mode,
                onTap: () async {
                  await consumerRef
                      .read(ProjectDependencyItems.appProviderState.notifier)
                      .changeAppTheme(theme: mode);
                  if (sheetContext.mounted) {
                    Navigator.of(sheetContext).pop();
                  }
                },
              ),
          ],
        );
      },
    ),
  );
}

final class _V2SheetScaffold extends StatelessWidget {
  const _V2SheetScaffold({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text(
                title,
                style: V2Typography.display(
                  fontSize: 22,
                  color: colorScheme.primary,
                ),
              ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

final class _V2RadioRow extends StatelessWidget {
  const _V2RadioRow({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 14.5,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? colorScheme.primary : Colors.transparent,
                border: Border.all(
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.onPrimaryContainer,
                  width: 2,
                ),
              ),
              child: isActive
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
