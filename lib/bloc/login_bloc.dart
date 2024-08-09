import 'package:bloc_login/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState.empty());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.update(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.update(password: event.password);
    } else if (event is LoginSubmitted) {
      yield LoginState.loading();
      try {
        final isSuccess = await userRepository.authenticate(
          username: state.username,
          password: state.password,
        );
        if (isSuccess) {
          yield LoginState.success();
        } else {
          yield LoginState.failure();
        }
      } catch (_) {
        yield LoginState.failure();
      }
    }
  }
}
