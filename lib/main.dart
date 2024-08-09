import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'repository/login_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: Login(userRepository: _userRepository),
        debugShowCheckedModeBanner: false,
    );
  }
}
