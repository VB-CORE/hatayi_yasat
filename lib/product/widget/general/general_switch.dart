import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/widget/general/title/general_body_title.dart';

final class GeneralSwitch extends StatelessWidget {
  const GeneralSwitch({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GeneralBodyTitle(title),
        Switch.adaptive(
          activeColor: context.general.colorScheme.secondary,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
