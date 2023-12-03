import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/favorite_places/view_model/favorite_places_provider.dart';
import 'package:vbaseproject/features/home_module/favorite_places/view_model/favorite_places_state.dart';
import 'package:vbaseproject/features/home_module/home_detail/home_detail_view.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/hive/favorite_place_cache_manager.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/package/shimmer/place_shimmer_list.dart';
import 'package:vbaseproject/product/utility/mixin/favorite_place_converter_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/card/place_card.dart';
import 'package:vbaseproject/product/widget/lottie/not_found_lottie.dart';

part '../widgets/favorite_places_loading.dart';
part '../widgets/favorite_places_not_found.dart';
part 'favorite_places_body_view.dart';

class FavoritePlacesView extends ConsumerStatefulWidget {
  const FavoritePlacesView({super.key});

  @override
  ConsumerState<FavoritePlacesView> createState() => _FavoritePlacesViewState();
}

class _FavoritePlacesViewState extends ConsumerState<FavoritePlacesView> {
  late final StateNotifierProvider<FavoritePlacesProvider, FavoritePlacesState>
      _favoritePlaceProvider;

  bool get isLoading => ref.watch(_favoritePlaceProvider).isLoading;

  @override
  void initState() {
    super.initState();
    _favoritePlaceProvider = StateNotifierProvider(
      (ref) => FavoritePlacesProvider(cacheService: FavoritePlaceCacheManager())
        ..initAndGetFavoritePlaces(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.favorite_title).tr(),
      ),
      body: CustomScrollView(
        slivers: [
          _FavoritePlacesBodyView(
            favoritePlaceProvider: _favoritePlaceProvider,
          ),
        ],
      ),
    );
  }
}
