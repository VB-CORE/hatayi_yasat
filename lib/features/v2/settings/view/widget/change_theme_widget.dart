part of '../settings_view.dart';

final class _ChangeThemeWidget extends ConsumerStatefulWidget {
  const _ChangeThemeWidget();

  @override
  ConsumerState<_ChangeThemeWidget> createState() => _ChangeThemeWidgetState();
}

final class _ChangeThemeWidgetState extends ConsumerState<_ChangeThemeWidget>
    with AppProviderMixin, _ChangeThemeMixin {
  @override
  Widget build(BuildContext context) {
    return GeneralExpansionTile(
      pageTitle: LocaleKeys.settings_themeTitle.tr(args: ['']),
      children: [
        ValueListenableBuilder(
          valueListenable: _isDarkThemeNotifier,
          builder: (_, isDarkTheme, __) => GeneralSwitch(
            title: isDarkTheme
                ? LocaleKeys.settings_themes_dark.tr()
                : LocaleKeys.settings_themes_light.tr(),
            value: isDarkTheme,
            onChanged: _updateIsSelected,
          ),
        ),
      ],
    );
  }
}

mixin _ChangeThemeMixin on ConsumerState<_ChangeThemeWidget> {
  AppProvider get appProvider;
  final ValueNotifier<bool> _isDarkThemeNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _isDarkThemeNotifier.value = appProvider.currentThemeMode == ThemeMode.dark;
  }

  void _updateIsSelected(bool value) {
    _isDarkThemeNotifier.value = value;
    _updateOperation(value);
  }

  void _updateOperation(bool value) {
    final theme = value ? ThemeMode.dark : ThemeMode.light;
    appProvider.changeAppTheme(theme: theme);
    SharedCache.instance.setTheme(theme);
  }
}
