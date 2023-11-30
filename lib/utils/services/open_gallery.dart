// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:provider/provider.dart';

Future<void> pickImage(BuildContext context) async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  final uplaodImageProvider =
      Provider.of<UplaodImageProvider>(context, listen: false);
  if (pickedFile != null) {
    uplaodImageProvider.uploadedImage = File(pickedFile.path);
  }
}
