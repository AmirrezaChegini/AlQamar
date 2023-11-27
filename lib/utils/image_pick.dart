import 'package:al_qamar/di.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick {
  static final ImagePicker _imagePicker = locator.get();

  ImagePick._();

  static Future<XFile?> pickImage() async {
    return await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
  }

  static Future<XFile?> pickPhoto() async {
    return await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
  }
}
