import 'package:hive/hive.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';

mixin HiveAdapterRegistrationMixin {
  void registerHiveAdapters() {
    Hive.registerAdapter(FavoritePlaceModelAdapter());
  }
}
