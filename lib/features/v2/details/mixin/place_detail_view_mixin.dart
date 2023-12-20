import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';

/// PlaceDetailViewMixin has the logic for the [PlaceDetailView] widget
mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  // TODO: Replace with parameter
  late final StoreModel model;

  final String randomImage = 'https://picsum.photos/seed/picsum/200/300';

  Future<void> callAction() async {
    // TODO: implement call logic with [model.phoneNumber]
  }

  Future<void> findThePlaceAction() async {
    // TODO: implement find the place logic with [model.address]
  }

  Future<void> goBackAction() async {
    // TODO: implement go back logic
  }
}
