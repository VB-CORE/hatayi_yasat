import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/model/auth/app_user.dart';

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
  const AuthError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
