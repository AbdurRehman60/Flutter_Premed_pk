import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';

Future<void> pickImage() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    UplaodImageProvider().uploadedImage = File(pickedFile.path);
  }
}
