import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_advance/function/image_picker.dart';
import 'package:riverpod_advance/screen/add_screen.dart';

final imagePathProvider = StateProvider<String>((ref) {
  return "";
});

final imageProvider = StateProvider<File?>(
  (ref) => null,
);

class ImagePicker extends ConsumerWidget {
  const ImagePicker({
    Key? key,
    required this.part3,
  }) : super(key: key);

  final GlobalKey<FormState> part3;

  @override
  Widget build(BuildContext context, ref) {
    return Consumer(
      builder: (context, refe, child) {
        return (refe.watch(addStateProvider) == 2)
            ? Container(
                margin: const EdgeInsets.all(20),
                child: Column(children: [
                  const Text(
                    "Data KTP",
                    style: TextStyle(fontSize: 20),
                  ),
                  FormField<File>(
                    key: part3,
                    validator: (value) {
                      if (ref.watch(imagePathProvider).isEmpty) {
                        return "This field must be entered";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                    builder: (FormFieldState<File> field) {
                      return Center(
                        child: InputDecorator(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              errorText: field.errorText,
                              errorStyle: const TextStyle(fontSize: 15)),
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Consumer(builder: (context, refer, _) {
                              return TextButton(
                                child: (refer.watch(imageProvider) == null)
                                    ? const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: FittedBox(
                                          child: Icon(Icons.camera_alt_rounded),
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(
                                                refer.watch(imageProvider)!),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                onPressed: () async {
                                  final result = await imagePicker();
                                  if (result != null) {
                                    refer.read(imageProvider.state).state =
                                        result;
                                    refer.read(imagePathProvider.state).state =
                                        result.path;
                                  } else {
                                    refer.read(imageProvider.state).state =
                                        result;
                                    refer.read(imagePathProvider.state).state =
                                        "";
                                  }
                                },
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ]),
              )
            : const SizedBox();
      },
    );
  }
}
