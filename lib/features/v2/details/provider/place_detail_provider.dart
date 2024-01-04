import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/project_dependency_mixin.dart';
import 'package:vbaseproject/features/v2/details/provider/place_detail_state.dart';

part 'place_detail_provider.g.dart';

@riverpod
final class PlaceDetailProvider extends _$PlaceDetailProvider
    with ProjectDependencyMixin {
  @override
  PlaceDetailState build() => const PlaceDetailState();

  Future<void> increaseVisitCount(StoreModel store) async {}
}
