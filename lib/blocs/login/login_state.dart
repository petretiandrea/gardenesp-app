part of 'login_cubit.dart';

@immutable
class LoginState {
  final bool isLoggingIn;
  final bool isFailure;
  final bool isSuccess;

  factory LoginState.empty() {
    return LoginState(
      isLoggingIn: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isLoggingIn: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory LoginState.error() {
    return LoginState(
      isLoggingIn: false,
      isFailure: true,
      isSuccess: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isLoggingIn: false,
      isFailure: false,
      isSuccess: true,
    );
  }

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const LoginState({
    required this.isLoggingIn,
    required this.isFailure,
    required this.isSuccess,
  });

  LoginState copyWith({
    bool? isLoggingIn,
    bool? isFailure,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'LoginState{isLoggingIn: $isLoggingIn, isFailure: $isFailure, isSuccess: $isSuccess}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginState &&
          runtimeType == other.runtimeType &&
          isLoggingIn == other.isLoggingIn &&
          isFailure == other.isFailure &&
          isSuccess == other.isSuccess);

  @override
  int get hashCode =>
      isLoggingIn.hashCode ^ isFailure.hashCode ^ isSuccess.hashCode;

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return new LoginState(
      isLoggingIn: map['isLoggingIn'] as bool,
      isFailure: map['isFailure'] as bool,
      isSuccess: map['isSuccess'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isLoggingIn': this.isLoggingIn,
      'isFailure': this.isFailure,
      'isSuccess': this.isSuccess,
    } as Map<String, dynamic>;
  }
//</editor-fold>
}
