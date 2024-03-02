import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/index.dart';

final class HomeState extends Equatable {
  const HomeState({
    required this.categories,
    this.isGridView = false,
    this.sortingType = SortingTypes.newest,
  });

  final List<CategoryModel> categories;
  final bool isGridView;
  final SortingTypes sortingType;
  @override
  List<Object> get props => [
        categories,
        isGridView,
      ];

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isGridView,
    SortingTypes? sortingType,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isGridView: isGridView ?? this.isGridView,
      sortingType: sortingType ?? this.sortingType,
    );
  }
}
