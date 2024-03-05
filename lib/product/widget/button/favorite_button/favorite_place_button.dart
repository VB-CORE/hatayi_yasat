import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/favorite_button/favorite_place_button_mixin.dart';
import 'package:lifeclient/product/widget/general/icon/general_favorite_icon.dart';

class FavoritePlaceButton extends ConsumerStatefulWidget {
  const FavoritePlaceButton({
    required this.store,
    super.key,
  });

  final StoreModel store;

  @override
  ConsumerState<FavoritePlaceButton> createState() =>
      _FavoritePlaceButtonState();
}

class _FavoritePlaceButtonState extends ConsumerState<FavoritePlaceButton>
    with
        AppProviderMixin<FavoritePlaceButton>,
        FavoritePlaceButtonMixin,
        AppProviderMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: GeneralFavoriteIcon(
        isFavorite: productStateWatch.favoritePlaces.any(
          (element) => element.documentId == widget.store.documentId,
        ),
      ),
    );
  }
}
