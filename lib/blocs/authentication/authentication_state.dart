part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);
}
