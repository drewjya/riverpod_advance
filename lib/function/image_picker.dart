import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<File?> imagePicker() async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.image,
  );
  if (result != null && result.files.first.path != null) {
    return File(result.files.first.path!);
  }
  return null;
}
