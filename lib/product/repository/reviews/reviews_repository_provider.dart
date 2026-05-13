import 'package:lifeclient/product/repository/reviews/reviews_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ReviewsRepository reviewsRepository(Ref ref) => ReviewsRepository();
