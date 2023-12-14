import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/index.dart';

class GeneralExpansionTile extends StatelessWidget {
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
          .copyWith(side: const BorderSide(width: 0.5)),
      elevation: 0,
      child: ExpansionTile(
        shape: LinearBorder.none,
        title: GeneralBodyTitle(
          pageTitle.tr(),
          fontWeight: FontWeight.bold,
        ),
        tilePadding: const PagePadding.generalAllNormal(),
        childrenPadding: const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyBottom(),
        children: children,
      ),
    );
  }
}
