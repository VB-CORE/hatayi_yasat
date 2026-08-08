import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading(this.provider);
  final AuthProvider provider;
  @override
  List<Object> get props => [provider];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);
  final UserModel user;
  @override
  List<Object> get props => [user];
}

/// Signed in but locked out. The account is already disabled server side and
/// the rules refuse every write; this state is what lets the app say why
/// instead of dropping the user at the login screen without a word.
final class AuthBanned extends AuthState {
  const AuthBanned(this.user);
  final UserModel user;
  String? get reason => user.bannedReason;
  @override
  List<Object> get props => [user];
}

final class AuthError extends AuthState {
  const AuthError(this.message, {this.provider});
  final String message;
  final AuthProvider? provider;
  @override
  List<Object?> get props => [message, provider];
}

extension AuthStateX on AuthState {
  UserModel? get user => switch (this) {
    Authenticated(:final user) => user,
    AuthBanned(:final user) => user,
    _ => null,
  };

  bool get isAuthenticated => this is Authenticated;

  bool get isBanned => this is AuthBanned;

  bool get canCreateGroup => user?.canCreateGroup ?? false;
}
