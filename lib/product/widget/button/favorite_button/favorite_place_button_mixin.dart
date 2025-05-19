import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_provider.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_state.dart';

mixin FavoritePlaceButtonMixin
    on
        AppProviderMixin<FavoritePlaceButton>,
        ConsumerState<FavoritePlaceButton> {
  late final StateNotifierProvider<FavoritePlaceProvider, FavoritePlaceState>
      _favoritePlaceProvider;

  bool get isLoading => ref.watch(_favoritePlaceProvider).isLoading;

  @override
  void initState() {
    super.initState();
    _favoritePlaceProvider = StateNotifierProvider(
      (ref) => FavoritePlaceProvider(
        cacheService: productProvider.storeModelCache,
      )..initAndCheckFavoritePlace(widget.store),
    );
  }

  Future<void> onPressed() async {
    if (isLoading) return;

    await ref.read(_favoritePlaceProvider.notifier).onSaved(widget.store);
  }
}
