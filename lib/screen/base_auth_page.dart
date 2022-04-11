import 'package:flutter/material.dart';

import 'package:riverpod_advance/service/validator.dart';
import '../function/size_extention.dart';
import 'package:riverpod_advance/components/custom_text_field.dart';
import 'package:riverpod_advance/function/get_theme_color.dart';

class BaseAuthScreen extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const BaseAuthScreen({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _usernameController = usernameController;
    final _passwordController = passwordController;

    final theme = getThemeColor(context);
    final form = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
      ),
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: context.getHeight() * 0.5,
            width: context.getWidth() * 0.8,
            decoration: BoxDecoration(
                color: theme.primaryColorLight,
                borderRadius: BorderRadius.circular(10)),
            child: Form(
              key: form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    FittedBox(
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomTextFormField(
                      password: false,
                      enabled: true,
                      label: "Username",
                      validator: Validator(minLenth: 5).checkEmpty,
                      controller: _usernameController,
                      icon: const Icon(Icons.person),
                    ),
                    const Spacer(),
                    CustomTextFormField(
                      enabled: true,
                      validator: Validator().validatePassword,
                      password: true,
                      icon: const Icon(Icons.vpn_key),
                      label: "Password",
                      controller: _passwordController,
                    ),
                    const Spacer(),
                    FittedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            onTap();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getWidth() / 6),
                          child: Text(text),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
