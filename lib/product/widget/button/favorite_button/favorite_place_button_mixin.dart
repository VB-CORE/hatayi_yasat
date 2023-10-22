import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/hive/favorite_place_cache_manager.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_provider.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_state.dart';

mixin FavoritePlaceButtonMixin on ConsumerState<FavoritePlaceButton> {
  late final StateNotifierProvider<FavoritePlaceProvider, FavoritePlaceState>
      _favoritePlaceProvider;

  bool get isLoading => ref.watch(_favoritePlaceProvider).isLoading;
  bool get isFavorite => ref.watch(_favoritePlaceProvider).isFavorite;

  @override
  void initState() {
    super.initState();
    _favoritePlaceProvider = StateNotifierProvider(
      (ref) => FavoritePlaceProvider(cacheService: FavoritePlaceCacheManager())
        ..initAndCheckFavoritePlace(FavoritePlaceModel.fromStore(widget.store)),
    );
  }

  Future<void> onPressed() async {
    if (isLoading) return;

    await ref
        .read(_favoritePlaceProvider.notifier)
        .onPressed(FavoritePlaceModel.fromStore(widget.store));
  }
}
