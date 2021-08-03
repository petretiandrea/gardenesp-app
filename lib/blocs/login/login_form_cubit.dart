import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gardenesp/blocs/authentication/authentication_bloc.dart';
import 'package:gardenesp/blocs/login/form_submission_status.dart';
import 'package:gardenesp/repository/user_repository.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  final AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepository;

  LoginFormCubit(this._userRepository, this._authenticationBloc)
      : super(LoginFormState.empty());

  void emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      formState: FormSubmissionInitial(),
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      formState: FormSubmissionInitial(),
    ));
  }

  void loginWithCredentials() async {
    emit(state.copyWith(formState: FormSubmissionLoading()));
    try {
      await _userRepository.signInWithCredentials(state.email, state.password);
      _authenticationBloc.add(LoggedIn());
      emit(state.copyWith(formState: FormSubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formState: FormSubmissionError(e.toString())));
    }
  }
}
