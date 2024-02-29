import 'package:equatable/equatable.dart';

final class MainTabState extends Equatable {
  const MainTabState({
    this.isScrolledBottom = false,
  });

  final bool isScrolledBottom;

  @override
  List<Object> get props => [isScrolledBottom];

  MainTabState copyWith({
    bool? isScrolledBottom,
  }) {
    return MainTabState(
      isScrolledBottom: isScrolledBottom ?? this.isScrolledBottom,
    );
  }
}
