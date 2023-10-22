import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';

mixin FavoritePlaceConverterMixin {
  StoreModel convertToStore(FavoritePlaceModel favoritePlace) {
    return StoreModel(
      name: favoritePlace.name,
      owner: favoritePlace.owner,
      address: favoritePlace.address,
      phone: favoritePlace.phone,
      images: favoritePlace.images,
      townCode: favoritePlace.townCode,
      createdAt: favoritePlace.createdAt,
      updatedAt: favoritePlace.updatedAt,
      isApproved: favoritePlace.isApproved,
      deviceID: favoritePlace.deviceID,
      description: favoritePlace.description,
      documentId: favoritePlace.documentId,
      category: favoritePlace.category != null
          ? CategoryModel(
              name: favoritePlace.category!.name,
              value: favoritePlace.category!.value,
            )
          : null,
    );
  }
}
