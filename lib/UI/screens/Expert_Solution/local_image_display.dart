import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:provider/provider.dart';

class LocalImageDisplay extends StatefulWidget {
  const LocalImageDisplay({super.key});

  @override
  State<LocalImageDisplay> createState() => _LocalImageDisplayState();
}

class _LocalImageDisplayState extends State<LocalImageDisplay> {
  // File? _image;
  @override
  Widget build(BuildContext context) {
    final uploadImageProvider = Provider.of<UplaodImageProvider>(context);

    Future<void> pickImage() async {
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        uploadImageProvider.uploadedImage = File(pickedFile.path);
        // setState(() {
        //   _image = File(pickedFile.path);
        // });
      }
    }

    return Column(
      children: <Widget>[
        if (uploadImageProvider.uploadedImage != null)
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
              uploadImageProvider.uploadedImage!,
              fit: BoxFit.fitHeight,
              width: 322,
              height: 200,
            ),
            // Implement LocalImageDisplay
          ),
        Expanded(
          child: CustomButton(
            color: PreMedColorTheme().primaryColorBlue100,
            textColor: PreMedColorTheme().primaryColorBlue800,
            iconSize: 0,
            isIconButton: true,
            onPressed: pickImage,
            buttonText: 'Choose from Gallery',
          ),
        ),
      ],
    );
  }
}
