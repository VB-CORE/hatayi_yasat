import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/hive/hive_cache_service_by_list.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';

final class FavoritePlaceCacheManager
    extends HiveCacheServiceByList<FavoritePlaceModel> {
  @override
  SharedKeys get key => SharedKeys.favoritePlaces;
}
