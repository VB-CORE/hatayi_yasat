part of '../../place_detail_view.dart';

final class PlaceDetailCommentsTab extends StatelessWidget {
  const PlaceDetailCommentsTab({required this.store, super.key});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RateCommentListView(
        isCommentEnabled: store.isCommentEnabled,
        placeId: store.documentId,
      ),
    );
  }
}
