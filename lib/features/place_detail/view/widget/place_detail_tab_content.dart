part of '../place_detail_view.dart';

final class _PlaceDetailTabContent extends StatelessWidget {
  const _PlaceDetailTabContent({
    required this.store,
    required this.tabs,
    required this.onCall,
    required this.onCopyAddress,
    required this.onOpenMaps,
  });

  final StoreModel store;
  final List<_PlaceDetailTab> tabs;
  final VoidCallback onCall;
  final VoidCallback onCopyAddress;
  final Future<void> Function(GeoPoint latLong) onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return ListenableBuilder(
      listenable: tabController,
      builder: (context, child) {
        return switch (tabs[tabController.index]) {
          _PlaceDetailTab.about => PlaceDetailAboutTab(
            store: store,
            onCall: onCall,
            onCopyAddress: onCopyAddress,
            onOpenMaps: onOpenMaps,
          ),
          _PlaceDetailTab.comments => PlaceDetailCommentsTab(store: store),
        };
      },
    );
  }
}
