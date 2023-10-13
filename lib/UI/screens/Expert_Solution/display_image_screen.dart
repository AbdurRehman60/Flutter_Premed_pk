import 'dart:io';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;

  DisplayImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            color: PreMedColorTheme().white,
          )
        ],
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
