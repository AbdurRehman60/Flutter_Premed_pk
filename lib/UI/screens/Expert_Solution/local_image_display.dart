import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/export.dart';

class LocalImageDisplay extends StatefulWidget {
  @override
  _LocalImageDisplayState createState() => _LocalImageDisplayState();
}

class _LocalImageDisplayState extends State<LocalImageDisplay> {
  File? _image;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_image != null)
          Image.file(
            _image!,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        Expanded(
          flex: 2,
          child: CustomButton(
            color: PreMedColorTheme().white,
            textColor: PreMedColorTheme().neutral400,
            isActive: true,
            iconSize: 0,
            isIconButton: true,
            isOutlined: false,
            onPressed: _pickImage,
            buttonText: 'Choose from Gallery',
          ),
        ),
      ],
    );
  }
}
