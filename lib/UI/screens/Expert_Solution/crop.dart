// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/display_image_screen.dart';

class CropImage extends StatefulWidget {

  const CropImage({super.key, required this.image});
  final File image;

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  CroppedFile? _croppedFile;

  @override
  void initState() {
    super.initState();
    // Automatically start cropping the image when the widget is created
    _cropImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 0.8 * screenWidth,
                  maxHeight: 0.7 * screenHeight,
                ),
                child: _croppedFile != null
                    ? Image.file(File(_croppedFile!.path))
                    : const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage(File image) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        _navigateToDisplayImageScreen(croppedFile);
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }

  void _navigateToDisplayImageScreen(CroppedFile croppedFile) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayImageScreen(
          image: File(croppedFile.path),
        ),
      ),
    );
  }

  // void _clear() {
  //   setState(() {
  //     _croppedFile = null;
  //   });
  // }
}
