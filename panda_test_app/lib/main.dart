import 'package:flutter/material.dart';
import 'package:panda_test_app/app/screens/login_screen.dart';
import 'package:panda_test_app/core/service_locator/di.dart';

void main() {
  // Initialize all dependencies via GetIt
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
