import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/enum/index.dart';

final class ApprovedPlaceQuery extends Equatable {
  const ApprovedPlaceQuery({
    required this.cityId,
    required this.categoryValues,
    required this.townCodes,
    required this.sortingType,
  });

  /// Firestore expands AND'ed `whereIn` filters into their combinations and
  /// caps the total at 30.
  /// https://firebase.google.com/docs/firestore/query-data/queries#standard_edition_limitations_2
  static const int maxDisjunctions = 30;

  static const String _categoryValueField = 'category.value';
  static const String _townCodeField = 'townCode';

  final String cityId;

  /// Selected category [CategoryModel.value]s; empty = all categories.
  final Set<int> categoryValues;

  /// Selected town codes; empty = all districts.
  final Set<int> townCodes;

  final SortingTypes sortingType;

  /// The `whereIn` axes of the query. Both [build] and [disjunctionCount] read
  /// this map, so a new axis is counted by the limit the moment it is added.
  Map<String, Set<int>> get _whereInAxes => {
    _categoryValueField: categoryValues,
    _townCodeField: townCodes,
  };

  /// Number of combinations Firestore expands this query into.
  int get disjunctionCount => _disjunctionsExcept(null);

  bool get isWithinLimit => disjunctionCount <= maxDisjunctions;

  /// How many towns may be selected alongside the other axes.
  int get maxSelectableTowns =>
      maxDisjunctions ~/ _disjunctionsExcept(_townCodeField);

  int get maxSelectableCategories =>
      maxDisjunctions ~/ _disjunctionsExcept(_categoryValueField);

  bool get isTownLimitExceeded => townCodes.length > maxSelectableTowns;

  bool get isCategoryLimitExceeded =>
      categoryValues.length > maxSelectableCategories;

  Query<StoreModel?> build(CollectionReference<StoreModel?> reference) {
    var query = reference.where(
      FirebaseQueryItems.cityId.name,
      isEqualTo: cityId,
    );
    for (final axis in _whereInAxes.entries) {
      if (axis.value.isEmpty) continue;
      query = query.where(axis.key, whereIn: axis.value.toList());
    }
    return query.orderBy(
      sortingType.field,
      descending: sortingType.descending,
    );
  }

  int _disjunctionsExcept(String? field) => _whereInAxes.entries
      .where((axis) => axis.key != field && axis.value.isNotEmpty)
      .fold(1, (total, axis) => total * axis.value.length);

  @override
  List<Object> get props => [
    cityId,
    categoryValues,
    townCodes,
    sortingType,
  ];
}
