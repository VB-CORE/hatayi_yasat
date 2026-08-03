part of '../settings_view.dart';

@immutable
final class _ChangeThemeWidget extends ConsumerWidget
    with AppProviderStateMixin {
  const _ChangeThemeWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = appStateWatch(ref).theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GeneralGroupSectionHeader(
          label: LocaleKeys.settings_appearanceTitle
              .tr(context: context)
              .toUpperCase(),
        ),
        RadioGroup<ThemeMode>(
          groupValue: currentTheme,
          onChanged: (value) async {
            if (value == null) return;
            await appProvider(ref).changeAppTheme(theme: value);
          },
          child: Column(
            children: ThemeMode.values
                .map(
                  (themeMode) => RadioListTile<ThemeMode>(
                    value: themeMode,
                    activeColor: context.general.colorScheme.primary,
                    contentPadding: const PagePadding.horizontalLowSymmetric(),
                    title: GeneralBodyTitle(
                      _themeLabel(themeMode).tr(context: context),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  String _themeLabel(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.dark => LocaleKeys.settings_themes_dark,
      ThemeMode.light => LocaleKeys.settings_themes_light,
      ThemeMode.system => LocaleKeys.settings_themes_system,
    };
  }
}
