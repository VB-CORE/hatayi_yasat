import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/widget/size/icon_size.dart';

final class GeneralCheckBox extends StatefulWidget {
  const GeneralCheckBox({
    required this.onUpdate,
    required this.title,
    this.initialValue = false,
    super.key,
  });
  final bool initialValue;
  final ValueChanged<bool> onUpdate;
  final String title;
  @override
  State<GeneralCheckBox> createState() => _GeneralCheckBoxState();
}

class _GeneralCheckBoxState extends State<GeneralCheckBox> {
  late bool _value;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _updateCheckBoxValue(bool value) {
    setState(() {
      _value = value;
    });
    widget.onUpdate(value);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _updateCheckBoxValue(!_value);
      },
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(widget.title, style: context.general.textTheme.titleSmall),
      leading: SizedBox.square(
        dimension: IconSize.medium.value,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Checkbox(
            activeColor: context.general.colorScheme.primary,
            value: _value,
            onChanged: (value) {
              if (value == null) return;
              _updateCheckBoxValue(value);
            },
          ),
        ),
      ),
    );
  }
}
