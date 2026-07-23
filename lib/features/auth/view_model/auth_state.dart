import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/model/auth/auth_provider.dart';
import 'package:lifeclient/product/model/auth/user_model.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();
  @override
  List<Object> get props => [];
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
    _ => null,
  };

  bool get isAuthenticated => this is Authenticated;
}
