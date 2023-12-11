import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CropImageScreen extends StatefulWidget {
  const CropImageScreen({super.key});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  File? _imageFile;

  Future<void> _cropImage(File image) async {
    final tempImage = img.decodeImage(image.readAsBytesSync());

    if (tempImage != null) {
      final croppedImage = img.copyCrop(
        tempImage,
        x: 200,
        y: 200,
        width: 400,
        height: 300,
      );

      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path, 'cropped_image.jpg');

      File(tempPath).writeAsBytesSync(img.encodeJpg(croppedImage));
      setState(() {
        _imageFile = File(tempPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crop Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(_imageFile!)
            else
              const Text('No image selected'),
            ElevatedButton(
              onPressed: () {
                final image =
                    ModalRoute.of(context)!.settings.arguments! as File;
                _cropImage(image);
              },
              child: const Text('Crop Image'),
            ),
            // CustomButton(
            //   buttonText: 'Continue',
            //   onPressed: () {
            //     if (_imageFile != null) {
            //       Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(
            //           builder: (context) => ExpertSolution(image: _imageFile!),
            //         ),
            //       );
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
