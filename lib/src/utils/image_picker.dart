import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker pickImage = ImagePicker();

  XFile? file = await pickImage.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("There is some error")));
}
