import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    required this.username,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.empty() {
    return LoginState(
      username: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      username: '',
      password: '',
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      username: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      username: '',
      password: '',
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState update({
    String? username,
    String? password,
  }) {
    return copyWith(
      username: username,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props =>
      [username, password, isSubmitting, isSuccess, isFailure];
}
