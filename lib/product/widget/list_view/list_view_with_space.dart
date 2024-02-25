import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/general/space/general_space_vertical.dart';

/// ListView with space between children
/// [children] is required
///
/// All: 20 padding with Bottom: 16
final class ListViewWithSpace extends StatelessWidget {
  const ListViewWithSpace({required this.children, super.key});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const PagePadding.all() + const PagePadding.onlyBottom(),
      itemCount: children.length,
      separatorBuilder: (BuildContext context, int index) {
        return const GeneralSpaceVertical.medium();
      },
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}
