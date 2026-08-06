import 'package:life_shared/life_shared.dart';

/// Deterministic placeholder distance for a [StoreModel] until the backend
/// exposes a real value.
///
/// Numbers are derived from [StoreModel.documentId] so a given place always
/// renders the same value. Rating and review count come from
/// [StoreModel.averageRating] / [StoreModel.ratingCount].
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

  /// 0.3 – 4.9 km
  double get distanceKm => (3 + _seed % 47) / 10;

  String get distanceLabel => '${distanceKm.toStringAsFixed(1)} km';
}
