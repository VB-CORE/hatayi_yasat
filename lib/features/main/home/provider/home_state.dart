import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/index.dart';

final class HomeState extends Equatable {
  const HomeState({
    required this.categories,
    this.isGridView = false,
    this.sortingType = SortingTypes.newest,
    this.isLoading = false,
  });

  final List<CategoryModel> categories;
  final bool isGridView;
  final SortingTypes sortingType;

  /// if true, the data is loading for new sorting type
  final bool isLoading;
  @override
  List<Object> get props => [
        categories,
        isGridView,
        sortingType,
        isLoading,
      ];

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isGridView,
    SortingTypes? sortingType,
    bool? isLoading,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isGridView: isGridView ?? this.isGridView,
      sortingType: sortingType ?? this.sortingType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
