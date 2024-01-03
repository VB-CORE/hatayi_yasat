import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart' show StringExtension;
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';

mixin PlaceDetailViewMixin on ConsumerState<PlaceDetailView> {
  late final StoreModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  Future<void> callAction() async {
    await RedirectionMixin.openToPhone(
      context: context,
      phoneNumber: model.phone,
    );
  }

  Future<void> findThePlaceAction() async {
    final address = model.address;
    if (address.ext.isNullOrEmpty) return;
    await RedirectionMixin.navigateToMapsWithTitle(
      context: context,
      placeAddress: address!,
    );
  }

  Future<void> goBackAction() async {
    context.pop();
  }
}
