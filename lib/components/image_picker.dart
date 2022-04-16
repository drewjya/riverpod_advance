import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_advance/function/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({
    Key? key,
    required this.keyForm,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final GlobalKey<FormState> keyForm;

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    // useState(controller.text);
    return SizedBox(
      height: 155,
      width: 400,
      child: FormField(
        key: widget.keyForm,
        validator: (File? value) {
          if (widget.controller.text == "") {
            return "Please upload picture";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.always,
        builder: (FormFieldState<File> field) {
          return SizedBox(
            height: 155,
            width: 400,
            child: InputDecorator(
              decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0))
                  .applyDefaults(
                    Theme.of(field.context).inputDecorationTheme,
                  )
                  .copyWith(errorText: field.errorText),
              child: SizedBox(
                height: 155,
                width: 400,
                child: TextButton(
                  onPressed: () async {
                    final data = await imagePicker();
                    if (data == null) {
                      widget.controller.text = "";
                    } else {
                      widget.controller.text = data.path;
                    }
                    setState(() {});
                  },
                  child: (widget.controller.text.isEmpty)
                      ? Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey,
                          child: const FittedBox(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(
                                        File(widget.controller.text)))),
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
