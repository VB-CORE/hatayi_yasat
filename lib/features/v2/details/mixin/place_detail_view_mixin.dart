import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart' show StringExtension;
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/details/view/place_detail_view.dart';
import 'package:vbaseproject/features/v2/details/view_model/place_detail_view_model.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/mixin/redirection_mixin.dart';

mixin PlaceDetailViewMixin
    on ConsumerState<PlaceDetailView>, AppProviderMixin<PlaceDetailView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(placeDetailViewModelProvider.notifier).init(
            model: widget.model,
            id: widget.id,
          );
    });
    // ref
    //     .read(placeDetailViewModelProvider.notifier)
    //     .init(model: widget.model, id: widget.id);
  }

  StoreModel get model {
    if (widget.model.documentId.isNotEmpty) return widget.model;
    return ref.watch(placeDetailViewModelProvider).storeModel;
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
