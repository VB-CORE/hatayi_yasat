import 'package:lifeclient/features/sub_feature/favorite/provider/favorite_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_view_model.g.dart';

@riverpod
final class FavoriteViewModel extends _$FavoriteViewModel {
  @override
  FavoriteState build() {
    return const FavoriteState();
  }

  void setGridView({required bool isGridView}) {
    if (state.isGridView == isGridView) return;
    state = state.copyWith(isGridView: isGridView);
  }

  void searchFavorites(String value) {
    state = state.copyWith(searchWord: value);
  }
}
