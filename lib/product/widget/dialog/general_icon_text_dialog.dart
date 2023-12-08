import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/widget/general/general_sub_title.dart';

/// Dialog contains only text and icon. If you want to show it on the screen, you can use the [show] command.
final class GeneralIconTextDialog extends StatelessWidget {
  const GeneralIconTextDialog({
    required this.title,
    required this.content,
    required this.actions,
    required this.icon,
    super.key,
  });

  final Icon icon;
  final String title;
  final String content;
  final List<Widget> actions;

  /// Display the dialog on the screen.
  static Future<void> show(
    BuildContext context,
    Icon icon,
    String title,
    String content,
    List<Widget> actions,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return GeneralIconTextDialog(
          title: title,
          content: content,
          actions: actions,
          icon: icon,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.general.colorScheme.secondary,
      icon: icon,
      iconColor: context.general.colorScheme.primary,
      title: GeneralSubTitle(
        value: title,
      ),
      // TODO: Fix => PR birleşince GeneralContentSubTitle widget olarak değiştirilecek.
      content: Text(
        content,
        style: context.general.textTheme.bodyMedium,
      ),

      actions: actions,
    );
  }
}
