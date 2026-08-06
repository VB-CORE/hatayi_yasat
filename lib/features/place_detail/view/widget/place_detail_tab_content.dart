part of '../place_detail_view.dart';

final class PlaceDetailTabContent extends StatelessWidget {
  const PlaceDetailTabContent({
    required this.store,
    required this.onCall,
    required this.onCopyAddress,
    required this.onOpenMaps,
    super.key,
  });

  final StoreModel store;
  final VoidCallback onCall;
  final VoidCallback onCopyAddress;
  final Future<void> Function(GeoPoint latLong) onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return ListenableBuilder(
      listenable: tabController,
      builder: (context, child) {
        return switch (_PlaceDetailTab.values[tabController.index]) {
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
