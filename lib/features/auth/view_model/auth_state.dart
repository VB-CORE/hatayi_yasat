import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/model/auth/app_user_model.dart';
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
  final AppUser user;
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
