import 'package:lifeclient/product/generated/assets.gen.dart';

enum AvatarType {
  a1,
  a2,
  a3,
  a4,
  a5,
  a6,
  a7;

  AssetGenImage get asset => switch (this) {
    AvatarType.a1 => Assets.avatars.a1,
    AvatarType.a2 => Assets.avatars.a2,
    AvatarType.a3 => Assets.avatars.a3,
    AvatarType.a4 => Assets.avatars.a4,
    AvatarType.a5 => Assets.avatars.a5,
    AvatarType.a6 => Assets.avatars.a6,
    AvatarType.a7 => Assets.avatars.a7,
  };
}
