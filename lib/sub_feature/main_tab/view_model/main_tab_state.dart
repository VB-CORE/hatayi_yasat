import 'package:equatable/equatable.dart';
import 'package:lifeclient/sub_feature/main_tab/model/main_tab.dart';

final class MainTabState extends Equatable {
  const MainTabState({
    this.isScrolledBottom = false,
    this.currentTab = MainTab.places,
  });

  final bool isScrolledBottom;
  final MainTab currentTab;

  @override
  List<Object> get props => [isScrolledBottom, currentTab];

  MainTabState copyWith({
    bool? isScrolledBottom,
    MainTab? currentTab,
  }) {
    return MainTabState(
      isScrolledBottom: isScrolledBottom ?? this.isScrolledBottom,
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
