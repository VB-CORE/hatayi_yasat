import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

final class GeneralCheckBox extends StatefulWidget {
  const GeneralCheckBox({
    required this.onUpdate,
    required this.title,
    this.value = false,
    super.key,
  });
  final bool value;
  final ValueChanged<bool> onUpdate;
  final String title;
  @override
  State<GeneralCheckBox> createState() => _GeneralCheckBoxState();
}

class _GeneralCheckBoxState extends State<GeneralCheckBox>
    with AutomaticKeepAliveClientMixin {
  bool _value = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void didUpdateWidget(covariant GeneralCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      Future.microtask(() {
        setState(() {
          _value = widget.value;
        });
      });
    }
  }

  void _updateCheckBoxValue(bool value) {
    setState(() {
      _value = value;
    });
    widget.onUpdate(value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
