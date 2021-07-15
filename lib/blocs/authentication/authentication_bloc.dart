import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardenesp/repository/UserRepository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _appStarted();
    } else if (event is LoggedIn) {
      yield* _mapLoggedIn();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOut();
    }
  }

  Stream<AuthenticationState> _appStarted() async* {
    try {
      final isSignedIn = await _userRepository.isLoggedIn();
      if (isSignedIn) {
        yield Authenticated(await _userRepository.currentUser());
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedIn() async* {
    yield Authenticated(await _userRepository.currentUser());
  }

  Stream<AuthenticationState> _mapLoggedOut() async* {
    await _userRepository.logout();
    yield Unauthenticated();
  }
}
