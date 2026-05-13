import 'package:lifeclient/product/repository/memories/memories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memories_repository_provider.g.dart';

@Riverpod(keepAlive: true)
MemoriesRepository memoriesRepository(Ref ref) => MemoriesRepository();
