import 'dart:io';

import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/crop.dart';
import 'package:premedpk_mobile_app/export.dart';

class DisplayImageScreen extends StatelessWidget {
  final File image;

  DisplayImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.file(image),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraScreen(),
                    ));
                  },
                  icon: const Icon(Icons.cancel),
                  iconSize: 42,
                  alignment: Alignment.bottomLeft,
                  color: PreMedColorTheme().primaryColorRed,
                ),
                SizedBox(
                  width: 240,
                  child: CustomButton(
                    buttonText: 'Continue to Crop Image',
                    onPressed: () {
                      _navigateToCropImage(context, image);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ExpertSolution(image: image),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check),
                  iconSize: 42,
                  color: PreMedColorTheme().primaryColorRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCropImage(BuildContext context, File image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropImage(
          image: image,
        ),
      ),
    );
  }
}
