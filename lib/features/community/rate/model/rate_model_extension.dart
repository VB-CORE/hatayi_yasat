import 'package:lifeclient/features/community/rate/model/rate_model.dart';

final _initialsSplitPattern = RegExp(r'\s+');

extension RateModelExtension on RateModel {
  String get initials {
    final parts = userName
        .trim()
        .split(_initialsSplitPattern)
        .where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    return parts.map((p) => p[0].toUpperCase()).take(2).join();
  }
}
