import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/home/provider/advertisement_board/advertisement_board_state.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'advertisement_board_view_model.g.dart';

@riverpod
final class AdvertisementBoardViewModel extends _$AdvertisementBoardViewModel
    with ProjectDependencyMixin {
  @override
  AdvertisementBoardState build() {
    fetchAdvertisements();
    return const AdvertisementBoardState.empty();
  }

  Future<void> fetchAdvertisements() async {
    final items = await firebaseService.getList<AdBoardModel>(
      model: AdBoardModel(),
      path: CollectionPaths.adBoard,
    );

    items.sort((a, b) => (a.adIndex ?? kZero).compareTo(b.adIndex ?? kZero));

    state = state.copyWith(advertisements: items);
  }
}
