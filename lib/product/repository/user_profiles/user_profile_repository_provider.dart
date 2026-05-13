import 'package:lifeclient/product/repository/user_profiles/user_profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_repository_provider.g.dart';

@Riverpod(keepAlive: true)
UserProfileRepository userProfileRepository(Ref ref) => UserProfileRepository();
