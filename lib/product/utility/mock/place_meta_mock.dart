import 'package:life_shared/life_shared.dart';

/// Deterministic placeholder meta (rating, review count, distance) for a
/// [StoreModel] until the backend exposes real values.
///
/// Numbers are derived from [StoreModel.documentId] so a given place always
/// renders the same values. Replace the getters with real model fields once the
/// data is available — this is the single seam for that swap.
final class PlaceMetaMock {
  const PlaceMetaMock(this.store);

  final StoreModel store;

  int get _seed {
    final source = store.documentId.isNotEmpty ? store.documentId : store.name;
    var hash = 0;
    for (final unit in source.codeUnits) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    return hash;
  }

  /// 4.0 – 4.9
  double get rating => 4 + (_seed % 10) / 10;

  /// 5 – 249
  int get reviewCount => 5 + _seed % 245;

  /// 0.3 – 4.9 km
  double get distanceKm => (3 + _seed % 47) / 10;

  String get ratingLabel => rating.toStringAsFixed(1);

  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
}

/// Placeholder per-category place counts for the category chips + eyebrow,
/// until the backend exposes real aggregates. Deterministic from category value.
final class CategoryCountMock {
  const CategoryCountMock._();

  static int forValue(int value) => 8 + value.abs() % 40;

  static int total(Iterable<int> values) =>
      values.fold(0, (sum, value) => sum + forValue(value));
}
