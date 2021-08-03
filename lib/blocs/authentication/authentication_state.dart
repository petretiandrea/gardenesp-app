part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {
  bool get isAuthenticated;
}

class Uninitialized extends AuthenticationState {
  @override
  bool get isAuthenticated => false;
}

class Unauthenticated extends AuthenticationState {
  @override
  bool get isAuthenticated => false;
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);

  @override
  bool get isAuthenticated => true;
}
