import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:provider/provider.dart';

class LocalImageDisplay extends StatefulWidget {
  @override
  _LocalImageDisplayState createState() => _LocalImageDisplayState();
}

class _LocalImageDisplayState extends State<LocalImageDisplay> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);

    Future<void> _pickImage() async {
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        askAnExpertProvider.uploadedImage = File(pickedFile.path);
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }

    return Column(
      children: <Widget>[
        if (_image != null)
          Container(
            height: 200,
            width: double.infinity,
            decoration: ShapeDecoration(
              color:
                  PreMedColorTheme().primaryColorBlue100, // Customize as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Image.file(
              _image!,
              fit: BoxFit.fitHeight,
              width: 322,
              height: 200,
            ),
            // Implement LocalImageDisplay
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
