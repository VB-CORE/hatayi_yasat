import 'package:life_shared/life_shared.dart';

mixin StoreModelMixin {
  bool findByNameOrCompanyName(StoreModel model, String value) {
    return model.owner.toLowerCase().contains(value.toLowerCase()) ||
        model.name.toLowerCase().contains(value.toLowerCase());
  }
}
