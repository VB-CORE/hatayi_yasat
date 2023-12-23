import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';

/// PlaceDetailViewMixin has the logic for the [PlaceDetailView] widget
mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  // TODO: Replace with parameter
  late final StoreModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  Future<void> callAction() async {
    // TODO: implement call logic with [model.phoneNumber]
  }

  Future<void> findThePlaceAction() async {
    // TODO: implement find the place logic with [model.address]
  }

  Future<void> goBackAction() async {
    context.pop();
  }
}
