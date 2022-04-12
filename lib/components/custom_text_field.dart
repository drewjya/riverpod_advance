import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

final passwordProvider = StateProvider<bool>((ref) {
  return true;
});
final autofocusProvider = StateProvider<bool>(
  (ref) => true,
);

class CustomTextFormField extends HookConsumerWidget {
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
    // final autofocus = useState(true);
    return SizedBox(
      width: width ?? 300,
      child: TextFormField(
        validator: validator,
        autofocus: ref.watch(autofocusProvider),
        onTap: () {
          ref.read(autofocusProvider.state).state = true;
        },
        controller: controller,
        obscureText: password ? ref.watch(passwordProvider) : false,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          fillColor: (enabled) ? Colors.white : Colors.grey.shade300,
          enabled: enabled,
          filled: true,
          labelText: label,
          suffixIcon: password
              ? GestureDetector(
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
        ),
      ),
    );
  }
}
