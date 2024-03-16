import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';

extension StoreModelExtension on StoreModel {
  String get updatedName {
    return name.ext.toTitleCase();
  }
}
