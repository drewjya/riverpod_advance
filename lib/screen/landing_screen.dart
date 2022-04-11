import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/function/size_extention.dart';
import 'package:riverpod_advance/provider/authentication/auth_provider.dart';
import 'package:riverpod_advance/provider/authentication/auth_state.dart';
import 'package:riverpod_advance/screen/login_screen.dart';
import 'package:riverpod_advance/screen/signup_screen.dart';
import 'package:riverpod_advance/screen/welcome_screen.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    Size size = Size(context.getWidth(), context.getHeight());
    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (next is AuthAuto) {
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
      },
    );
    return Scaffold(
      // backgroundColor: Colors.blueAccent.shade700,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (size.width * 0.7 < 380) ? size.width * 0.7 : 380,
              height: (size.height * 0.45 < 400) ? size.height * 0.45 : 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/imfi.jpeg",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(
              flex: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                onPrimary: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  )),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text("Login")),
            ),
            const Spacer(
              flex: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                onPrimary: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  )),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text("Signup")),
            ),
            const Spacer(
              flex: 13,
            ),
          ],
        ),
      ),
    );
  }
}
