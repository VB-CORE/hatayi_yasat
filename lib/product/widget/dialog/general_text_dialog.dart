import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/model/enum/index.dart';
import 'package:vbaseproject/product/widget/general/title/general_content_sub_title.dart';
import 'package:vbaseproject/product/widget/general/title/general_sub_title.dart';

/// Dialog contains only text. If you want to show it on the screen, you can use the [show] command.
@immutable
final class GeneralTextDialog extends StatelessWidget {
  const GeneralTextDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  final String title;
  final String content;
  final List<Widget> actions;

  /// Display the dialog on the screen.
  static Future<void> show(
    BuildContext context,
    String title,
    String content,
    List<Widget> actions,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return GeneralTextDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.general.colorScheme.secondary,
      title: GeneralSubTitle(value: title),
      content: GeneralContentSubTitle(
        value: content,
        maxLine: TextFieldMaxLengths.maxLine,
      ),
      actions: actions,
    );
  }
}
