import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_provider.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_state.dart';

mixin FavoritePlaceButtonMixin
    on
        AppProviderMixin<FavoritePlaceButton>,
        ConsumerState<FavoritePlaceButton> {

  /// Todo: Update to better manager
  late final NotifierProvider<FavoritePlaceProvider, FavoritePlaceState>
      _favoritePlaceProvider = NotifierProvider(
    () => FavoritePlaceProvider(
      cacheService: productProvider.storeModelCache,
      storeModel: widget.store,
    ),
  );

  NotifierProvider<FavoritePlaceProvider, FavoritePlaceState>
      get favoritePlaceProvider => _favoritePlaceProvider;

  bool get isLoading => ref.watch(_favoritePlaceProvider).isLoading;

  @override
  void initState() {
    super.initState();
  }

  Future<void> onPressed() async {
    if (isLoading) return;

    await ref.read(_favoritePlaceProvider.notifier).onSaved(widget.store);
  }
}
