import 'package:bloc_login/bloc/login_bloc.dart';
import 'package:bloc_login/bloc/login_event.dart';
import 'package:bloc_login/bloc/login_state.dart';
import 'package:bloc_login/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final UserRepository userRepository;

  Login({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 70),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'Username'),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginUsernameChanged(username: value));
              },
              validator: (value) => value?.isEmpty == true ? 'Please enter username' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginPasswordChanged(password: value));
              },
              validator: (value) => value?.isEmpty == true ? 'Please enter password' : null,
            ),
            const Spacer(),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                    if (Form.of(context)?.validate() == true) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey;
                        }
                        return Colors.blue;
                      },
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: state.isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ulanib bolmadi')),
                  );
                } else if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Sucsesfuly')),
                  );
                  // Navigate to the next screen or reset the form.
                }
              },
              child: Container(), // This can be an empty container as we are using listener.
            ),
          ],
        ),
      ),
    );
  }
}
