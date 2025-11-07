part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final GithubUserEntity githubUser;

  AuthSuccess({required this.githubUser});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}
