import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/index.dart';

final class HomeState extends Equatable {
  const HomeState({
    required this.categories,
    this.isGridView = false,
    this.sortingType = SortingTypes.newest,
    this.isLoading = false,
    this.categoryValues = const {},
    this.townCodes = const {},
    this.openNow = false,
    this.favoritesOnly = false,
  });

  final List<CategoryModel> categories;
  final bool isGridView;
  final SortingTypes sortingType;

  /// Selected category [CategoryModel.value]s; empty = all categories.
  final Set<int> categoryValues;

  /// Selected town codes; empty = all districts.
  final Set<int> townCodes;

  /// Client-side: only currently-open places.
  final bool openNow;

  /// Client-side: only favorited places.
  final bool favoritesOnly;

  /// if true, the data is loading for a new sorting/filter selection
  final bool isLoading;

  bool get hasActiveFilters =>
      categoryValues.isNotEmpty ||
      townCodes.isNotEmpty ||
      openNow ||
      favoritesOnly;

  /// Whether the place list must be filtered in memory (open/favorites).
  bool get hasClientFilters => openNow || favoritesOnly;

  @override
  List<Object> get props => [
        categories,
        isGridView,
        sortingType,
        isLoading,
        categoryValues,
        townCodes,
        openNow,
        favoritesOnly,
      ];

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isGridView,
    SortingTypes? sortingType,
    bool? isLoading,
    Set<int>? categoryValues,
    Set<int>? townCodes,
    bool? openNow,
    bool? favoritesOnly,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isGridView: isGridView ?? this.isGridView,
      sortingType: sortingType ?? this.sortingType,
      isLoading: isLoading ?? this.isLoading,
      categoryValues: categoryValues ?? this.categoryValues,
      townCodes: townCodes ?? this.townCodes,
      openNow: openNow ?? this.openNow,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    );
  }
}
