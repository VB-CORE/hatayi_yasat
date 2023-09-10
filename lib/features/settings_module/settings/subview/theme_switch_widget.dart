import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({required this.onChanged, super.key});
  final ValueSetter<bool> onChanged;

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool _isSelected = false;

  void _updateIsSelected(bool value) {
    _isSelected = value;
    setState(() {});
    widget.onChanged(_isSelected);
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
