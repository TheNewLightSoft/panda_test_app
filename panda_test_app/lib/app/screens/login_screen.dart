import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda_test_app/app/cubits/chat/bloc.dart';
import 'package:panda_test_app/app/cubits/login/bloc.dart';
import 'package:panda_test_app/app/screens/chat_screen.dart';
import 'package:panda_test_app/core/service_locator/di.dart';
import 'package:panda_test_app/core/utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => LoginCubit(getIt.get()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3),
                const _HeaderText(),
                const SizedBox(height: 16),
                _CustomTextField(
                  controller: usernameController,
                  labelText: 'Username',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                _CustomTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                const Spacer(flex: 2),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: _loginStateListener,
                  builder: (context, state) => state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _LoginButton(
                          usernameController: usernameController,
                          passwordController: passwordController,
                        ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginStateListener(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      _showSnackBar(context, '✅ Login successful! Token: ${state.userSession.token}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChatCubit(getIt.get()),
            child: const ChatScreen(),
          ),
        ),
      );
    } else if (state is LoginFailure) {
      _showSnackBar(context, '❌ Error: ${state.error}');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        duration: const Duration(milliseconds: 1200),
        content: Text(message, style: const TextStyle(color: PandaColors.richBlack)),
        backgroundColor: PandaColors.greyLess,
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Welcome Back!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: PandaColors.brown,
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputAction textInputAction;
  final bool obscureText;

  const _CustomTextField({
    required this.controller,
    required this.labelText,
    required this.textInputAction,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      obscureText: obscureText,
      style: const TextStyle(color: PandaColors.brown),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: PandaColors.brown),
        labelText: labelText,
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        border: PandaBorders.focusedBorder,
        focusedBorder: PandaBorders.focusedBorder,
        enabledBorder: PandaBorders.unfocusedBorder,
        disabledBorder: PandaBorders.focusedBorder,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _LoginButton({
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(PandaColors.amber),
          overlayColor: WidgetStateProperty.all(PandaColors.brown),
        ),
        onPressed: () {
          final username = usernameController.text.trim();
          final password = passwordController.text.trim();

          if (username.isNotEmpty && password.isNotEmpty) {
            context.read<LoginCubit>().login(username, password);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                duration: Duration(milliseconds: 1200),
                content: Text(
                  'ℹ️ Username and password cannot be empty.',
                  style: TextStyle(color: PandaColors.richBlack),
                ),
                backgroundColor: PandaColors.greyLess,
              ),
            );
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: PandaColors.greyLess,
          ),
        ),
      ),
    );
  }
}
