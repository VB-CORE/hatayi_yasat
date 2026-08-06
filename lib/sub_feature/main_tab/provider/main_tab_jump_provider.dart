import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_tab_jump_provider.g.dart';

@riverpod
final class MainTabJumpNotifier extends _$MainTabJumpNotifier {
  @override
  int? build() => null;

  void requestTab(int index) => state = index;

  void consume() => state = null;
}
