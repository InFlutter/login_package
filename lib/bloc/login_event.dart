import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}
