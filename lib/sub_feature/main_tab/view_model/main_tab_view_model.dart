import 'package:lifeclient/sub_feature/main_tab/view_model/main_tab_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_tab_view_model.g.dart';

@riverpod
final class MainTabViewModel extends _$MainTabViewModel {
  @override
  MainTabState build() {
    return const MainTabState();
  }

  void updateBottomBarValue({required bool isScrolledBottom}) {
    if (state.isScrolledBottom == isScrolledBottom) return;
    state = state.copyWith(isScrolledBottom: isScrolledBottom);
  }
}
