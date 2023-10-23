import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_button_mixin.dart';

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
    with AppProviderMixin<FavoritePlaceButton>, FavoritePlaceButtonMixin {

      
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: context.general.colorScheme.primary,
      ),
    );
  }
}
