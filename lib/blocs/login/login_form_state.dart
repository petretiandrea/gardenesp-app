part of 'login_form_cubit.dart';

@immutable
class LoginFormState {
  final String email;
  final String password;
  final FormSubmissionState formState;

  bool get validEmail => true;
  bool get validPassword => true;

  factory LoginFormState.empty() => LoginFormState(
        email: "",
        password: "",
        formState: FormSubmissionInitial(),
      );

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const LoginFormState({
    required this.email,
    required this.password,
    required this.formState,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    FormSubmissionState? formState,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      formState: formState ?? this.formState,
    );
  }

  @override
  String toString() {
    return 'LoginFormState{email: $email, password: $password, formState: $formState}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginFormState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          formState == other.formState);

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ formState.hashCode;

  factory LoginFormState.fromMap(Map<String, dynamic> map) {
    return new LoginFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      formState: map['formState'] as FormSubmissionState,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': this.email,
      'password': this.password,
      'formState': this.formState,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
