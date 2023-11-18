import 'package:flutter/material.dart';
import 'package:vbaseproject/product/common/color_common.dart';
import 'package:vbaseproject/sub_feature/tab/model/general_tab_model.dart';

@immutable
final class GeneralTabBar extends StatelessWidget {
  const GeneralTabBar({required this.tabItems, super.key});
  final List<GeneralTabModel> tabItems;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabItems.map((e) => Tab(icon: e.icon)).toList(),
      indicatorColor: Colors.transparent,
      labelColor: _whiteAndBlackForThemeColor(context),
      unselectedLabelColor:
          _whiteAndBlackForThemeColor(context).withOpacity(0.6),
    );
  }

  Color _whiteAndBlackForThemeColor(BuildContext context) =>
      ColorCommon(context).whiteAndBlackForTheme;
}
