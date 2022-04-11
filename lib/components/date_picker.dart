import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DatePicker extends HookWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool enabled;
  const DatePicker(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.only(bottom: 20),
      width: 340,
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.always,
        onTap: (enabled)
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                showDatePicker(
                        context: context,
                        initialDate: DateTime(2005),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2010))
                    .then((pickedDate) {
                  if (pickedDate == null) {
                    return;
                  }
                  useState(controller.text =
                      DateFormat("dd-MM-yyyy").format(pickedDate).toString());
                });
              }
            : null,
        decoration: InputDecoration(
          fillColor: (enabled) ? null : Colors.grey.shade300,
          filled: (enabled) ? false : (!enabled),
          labelText: "Date of Birth",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue.shade900,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
