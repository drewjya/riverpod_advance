import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

final passwordProvider = StateProvider<bool>((ref) {
  return true;
});

class CustomTextFormField extends ConsumerWidget {
  const CustomTextFormField({
    Key? key,
    required this.password,
    required this.enabled,
    required this.validator,
    required this.label,
    required this.controller,
    this.border,
    this.width,
    this.icon,
  }) : super(key: key);

  final bool enabled;
  final bool? border;
  final double? width;
  final Widget? icon;
  final String? Function(String?)? validator;
  final String label;
  final bool password;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      width: width ?? 300,
      child: TextFormField(
        validator: validator,
        obscureText: password ? ref.watch(passwordProvider) : false,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          fillColor: (enabled) ? Colors.white : Colors.grey.shade300,
          enabled: enabled,
          filled: true,
          // labelText: label,

          label: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: enabled ? Colors.white : Colors.grey.shade300,
              ),
              child: Text(label),
            ),
          ),
          suffixIcon: password
              ? InkWell(
                  onTap: () {
                    ref.read(passwordProvider.state).state =
                        !ref.read(passwordProvider);
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color:
                        ref.watch(passwordProvider) ? Colors.grey : Colors.blue,
                  ),
                )
              : null,
          prefixIcon: icon,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: (border == null)
                ? BorderSide.none
                : BorderSide(
                    color: Colors.blue.shade900,
                    width: 2,
                  ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
