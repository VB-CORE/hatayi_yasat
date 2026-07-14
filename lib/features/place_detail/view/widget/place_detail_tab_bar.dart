part of '../place_detail_view.dart';

final class PlaceDetailTabBar extends StatelessWidget {
  const PlaceDetailTabBar({required this.store, super.key});

  final StoreModel store;

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
          Tab(text: LocaleKeys.placeDetailView_tabAbout.tr()),
          Tab(
            text: LocaleKeys.placeDetailView_tabComments.tr(
              args: ['${PlaceMetaMock(store).reviewCount}'],
            ),
          ),
        ],
      ),
    );
  }
}
