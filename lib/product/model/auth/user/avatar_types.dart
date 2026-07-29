import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/model/auth/user/avatar_type_model.dart';

abstract final class AvatarTypes {
  static final List<AvatarTypeModel> all = Assets.avatars.values
      .map(
        (asset) => AvatarTypeModel(
          name: asset.path.split('/').last.split('.').first,
          path: asset.path,
        ),
      )
      .toList();

  static AvatarTypeModel byName(String name) =>
      all.firstWhere((type) => type.name == name, orElse: () => all.first);
}
