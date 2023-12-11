import 'dart:io';
import 'package:flutter/material.dart';

class UplaodImageProvider extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }

  File? _uploadedImage;
  File? get uploadedImage => _uploadedImage;
  set uploadedImage(File? value) {
    _uploadedImage = value;
    notify();
  }

  void initToNull() {
    uploadedImage = null;
  }
}
