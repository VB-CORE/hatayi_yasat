part of '../place_detail_view.dart';

final class _PlaceDetailTabBar extends StatelessWidget {
  const _PlaceDetailTabBar({required this.tabs});

  final List<_PlaceDetailTab> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: TabBar(
        dividerColor: AppColors.ink100,
        labelColor: AppColors.navy,
        unselectedLabelColor: AppColors.navy,
        indicatorColor: AppColors.coral,
        labelStyle: AppText.body.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppText.body.copyWith(
          fontWeight: FontWeight.normal,
        ),
        tabs: [
          for (final tab in tabs) Tab(text: tab.labelKey.tr()),
        ],
      ),
    );
  }
}
