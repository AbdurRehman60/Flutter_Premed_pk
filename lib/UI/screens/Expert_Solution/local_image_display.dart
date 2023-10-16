import 'dart:io';
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
            width: 322,
            height: 200,
          ),
        Expanded(
          flex: 1,
          child: CustomButton(
            color: PreMedColorTheme().primaryColorBlue100,
            textColor: PreMedColorTheme().primaryColorBlue800,
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
