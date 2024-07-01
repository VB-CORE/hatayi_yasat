import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/general/index.dart';

@immutable
final class GeneralExpansionTile extends StatelessWidget {
  const GeneralExpansionTile({
    required this.pageTitle,
    required this.children,
    super.key,
  });

  final String pageTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: CustomRadius.large,
        side: BorderSide(
          color: context.general.colorScheme.onPrimaryContainer,
        ),
      ),
      elevation: 0,
      child: ExpansionTile(
        shape: LinearBorder.none,
        trailing: Icon(
          Icons.keyboard_arrow_down,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
        title: GeneralBodyTitle(
          pageTitle,
          fontWeight: FontWeight.w600,
        ),
        children: children,
      ),
    );
  }
}
