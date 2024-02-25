import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/details/view_model/place_detail_state.dart';

part 'place_detail_view_model.g.dart';

@riverpod
final class PlaceDetailViewModel extends _$PlaceDetailViewModel
    with ProjectDependencyMixin {
  PlaceDetailViewModel();

  @override
  PlaceDetailState build() => PlaceDetailState(storeModel: StoreModel.empty());

  void init({required StoreModel model, required String id}) {
    state = state.copyWith(storeModel: model);
    if (model.documentId.isNotEmpty) return;
    fetchStoreModel(id);
  }

  Future<void> fetchStoreModel(String id) async {
    state = state.copyWith(isFetching: true);
    final item = await appProvider.customService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: id,
    );
    state = state.copyWith(
      storeModel: item,
      isFetching: false,
      isError: item == null,
    );
  }
}
