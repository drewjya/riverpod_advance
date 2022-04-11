import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/model/users_model.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/authentication/auth_state.dart';
import 'package:riverpod_advance/screen/base_auth_page.dart';
import 'package:riverpod_advance/screen/welcome_screen.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = useTextEditingController();
    final username = useTextEditingController();
    ref.listen(authProvider, (previous, next) {
      if (next is AuthFailed) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 750), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: Colors.redAccent,
              title: const Text(
                "Notification",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: const Text("Login Failed"),
            );
          },
        );
      } else if (next is AuthSuccess) {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 750), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: Colors.greenAccent,
              title: const Text(
                "Notification",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: const Text("Login Success"),
            );
          },
        );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
                (route) => false);
      }
    });
    return BaseAuthScreen(
      passwordController: password,
      usernameController: username,
      onTap: () => ref.read(authProvider.notifier).onLogin(
            UserModel(
              username: username.text,
              password: password.text,
            ),
          ),
      text: "Log In",
    );
  }
}
