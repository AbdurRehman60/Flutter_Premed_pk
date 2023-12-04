import 'dart:io';
import 'package:flutter/material.dart';

class UplaodImageProvider extends ChangeNotifier {
  notify() {
    notifyListeners();
  }

  File? _uploadedImage;
  File? get uploadedImage => _uploadedImage;
  set uploadedImage(File? value) {
    _uploadedImage = value;
    notify();
  }

  void initToNull() {
    _uploadedImage = null;
  }
}
