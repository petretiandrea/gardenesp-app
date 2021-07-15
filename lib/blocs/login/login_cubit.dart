import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gardenesp/repository/UserRepository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository;

  LoginCubit(this._userRepository) : super(LoginState.empty());

  Future<void> loginWithCredentials(String email, String password) async {
    emit(LoginState.loading());
    try {
      await _userRepository.signInWithCredentials(email, password);
      emit(LoginState.success());
    } catch (e) {
      emit(LoginState.error());
    }
  }
}
