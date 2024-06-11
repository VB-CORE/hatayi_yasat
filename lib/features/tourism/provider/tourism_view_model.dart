import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/tourism/provider/tourism_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tourism_view_model.g.dart';

@riverpod
final class TourismViewModel extends _$TourismViewModel
    with ProjectDependencyMixin {
  @override
  TourismState build() => const TourismState();

  Future<void> fetchTouristicPlaces() async {
    final placeListResponse =
        await firebaseService.getList<TouristicPlaceModel>(
      model: TouristicPlaceModel(),
      path: CollectionPaths.touristicPlaces,
    );

    state = state.copyWith(placeList: placeListResponse);
  }
}
