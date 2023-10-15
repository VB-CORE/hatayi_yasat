import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';

final class ThemeSwitchWidget extends ConsumerStatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  ConsumerState<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends ConsumerState<ThemeSwitchWidget>
    with AppProviderMixin {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = appProvider.currentThemeMode == ThemeMode.dark;
  }

  void _updateIsSelected(bool value) {
    setState(() {
      _isSelected = value;
    });
    _updateOperation(value);
  }

  void _updateOperation(bool value) {
    final theme = value ? ThemeMode.dark : ThemeMode.light;
    appProvider.changeAppTheme(theme: theme);
    SharedCache.instance.setTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: context.general.colorScheme.secondary,
      value: _isSelected,
      onChanged: _updateIsSelected,
    );
  }
}
