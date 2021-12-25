import 'package:bloc/bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardenesp/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(Uninitialized()) {
    on<AppStarted>((event, emit) => _appStarted(emit));
    on<LoggedIn>((event, emit) => _mapLoggedIn(emit));
    on<LoggedOut>((event, emit) => _mapLoggedOut(emit));
  }

  void _appStarted(Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await _userRepository.isLoggedIn();
      if (isSignedIn) {
        emit(Authenticated(await _userRepository.currentUser()));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void _mapLoggedIn(Emitter<AuthenticationState> emit) async {
    emit(Authenticated(await _userRepository.currentUser()));
  }

  void _mapLoggedOut(Emitter<AuthenticationState> emit) async {
    await _userRepository.logout();
    emit(Unauthenticated());
  }
}
