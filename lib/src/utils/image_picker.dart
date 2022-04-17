import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker pickImage = ImagePicker();

  XFile? file = await pickImage.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  print("There is some error");
}
