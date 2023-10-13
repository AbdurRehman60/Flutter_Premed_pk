import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen({required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    try {
      await _initializeControllerFuture;
      final XFile imageFile = await _controller.takePicture();

      // Create an instance of ImageCropper
      final imageCropper = ImageCropper();

      // Crop the captured image
      final croppedImage = await imageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio:
            CropAspectRatio(ratioX: 1, ratioY: 1), // Customize aspect ratio
        compressQuality: 100, // Adjust the image quality (0-100)
        maxHeight: 1000, // Adjust maximum height
        maxWidth: 1000, // Adjust maximum width
      );

      // Check if cropping was successful and navigate to the display screen
      if (croppedImage != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DisplayImageScreen(imagePath: croppedImage.path),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(child: CameraPreview(_controller)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: takePicture, // Call the takePicture method
                    child: Icon(Icons.camera_alt, size: 36),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;

  DisplayImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Captured Image'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigate back or perform other actions if needed
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
