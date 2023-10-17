import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_button_mixin.dart';

class FavoritePlaceButton extends ConsumerStatefulWidget {
  const FavoritePlaceButton({
    required this.name,
    required this.address,
    required this.images,
    required this.townCode,
    super.key,
    this.documentId = '',
  });

  FavoritePlaceButton.fromStore({
    required StoreModel store,
    super.key,
  })  : name = store.name,
        address = store.address,
        documentId = store.documentId,
        images = store.images,
        townCode = store.townCode;

  final String name;
  final String? address;
  final List<String> images;
  final int townCode;
  final String documentId;

  @override
  ConsumerState<FavoritePlaceButton> createState() =>
      _FavoritePlaceButtonState();
}

class _FavoritePlaceButtonState extends ConsumerState<FavoritePlaceButton>
    with FavoritePlaceButtonMixin {
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
