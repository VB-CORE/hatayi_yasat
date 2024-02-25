import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/decorations/custom_border_side.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

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
      shape: context.border.roundedRectangleAllBorderNormal
          .copyWith(side: CustomBorderSides.medium),
      elevation: 0,
      child: ExpansionTile(
        shape: LinearBorder.none,
        title: GeneralBodyTitle(
          pageTitle.tr(context: context),
          fontWeight: FontWeight.bold,
        ),
        childrenPadding: const PagePadding.horizontal16Symmetric(),
        children: children,
      ),
    );
  }
}
