part of 'login_form_cubit.dart';

@immutable
class LoginFormState {
  final String email;
  final String password;

  bool get validEmail => true;
  bool get validPassword => true;

  factory LoginFormState.empty() => LoginFormState(email: "", password: "");

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const LoginFormState({
    required this.email,
    required this.password,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'LoginFormState{email: $email, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginFormState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  factory LoginFormState.fromMap(Map<String, dynamic> map) {
    return new LoginFormState(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': this.email,
      'password': this.password,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}
