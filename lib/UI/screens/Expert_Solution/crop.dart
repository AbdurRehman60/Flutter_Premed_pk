import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/display_image_screen.dart';
import 'package:premedpk_mobile_app/export.dart';

class CropImage extends StatefulWidget {
  final File image;
  const CropImage({super.key, required this.image});

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    : Image.file(widget.image),
              ),
            ),
            SizedBoxes.verticalMedium,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _clear();
                  },
                  backgroundColor: PreMedColorTheme().primaryColorBlue,
                  tooltip: 'Delete',
                  child: const Icon(Icons.delete),
                ),
                if (_croppedFile == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _cropImage().then((_) {
                          // Navigate to DisplayImage after cropping
                          if (_croppedFile != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayImageScreen(
                                  image: File(_croppedFile!.path),
                                ),
                              ),
                            );
                          }
                        });
                      },
                      backgroundColor: PreMedColorTheme().primaryColorRed,
                      tooltip: 'Crop',
                      child: const Icon(Icons.crop),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: PreMedColorTheme().primaryColorRed,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }

  void _clear() {
    setState(() {
      _croppedFile = null;
    });
  }
}
