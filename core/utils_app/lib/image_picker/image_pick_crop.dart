import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickCrop {
  static Future<File?> process({
    required ImageSource source,
    required List<CropAspectRatioPreset> ratio,
  }) async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: source, imageQuality: 50);

    final croppedImage = await ImageCropper().cropImage(
      aspectRatioPresets: ratio,
      sourcePath: pickedFile!.path,
      maxWidth: 500,
      maxHeight: 500,
    );

    File? imageFile = File(croppedImage!.path);

    return Future.delayed(const Duration(seconds: 1), () => imageFile);
  }
}
