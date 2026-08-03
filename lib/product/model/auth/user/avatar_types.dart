import 'package:collection/collection.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type_model.dart';

abstract final class AvatarTypes {
  static final List<AvatarTypeModel> all = Assets.avatars.values
      .mapIndexed(
        (index, asset) => AvatarTypeModel(id: index + 1, path: asset.path),
      )
      .toList();

  static AvatarTypeModel byId(int id) =>
      all.firstWhere((type) => type.id == id, orElse: () => all.first);
}
