import 'package:lifeclient/product/repository/posts/posts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_repository_provider.g.dart';

@Riverpod(keepAlive: true)
PostsRepository postsRepository(Ref ref) => PostsRepository();
