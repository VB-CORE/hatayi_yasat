import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class HomeState extends Equatable {
  const HomeState({required this.categories, this.isGridView = false});

  final List<CategoryModel> categories;
  final bool isGridView;
  @override
  List<Object> get props => [
        categories,
        isGridView,
      ];

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isGridView,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isGridView: isGridView ?? this.isGridView,
    );
  }
}
