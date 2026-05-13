import 'package:lifeclient/product/repository/favorites/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository_provider.g.dart';

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepository();
