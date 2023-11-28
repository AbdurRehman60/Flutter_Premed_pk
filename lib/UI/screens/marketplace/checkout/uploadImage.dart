import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:provider/provider.dart';

class LocalImageDisplayCheckout extends StatefulWidget {
  const LocalImageDisplayCheckout({super.key});

  @override
  _LocalImageDisplayCheckoutState createState() =>
      _LocalImageDisplayCheckoutState();
}

class _LocalImageDisplayCheckoutState extends State<LocalImageDisplayCheckout> {
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          decoration: ShapeDecoration(
            color: PreMedColorTheme().white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_image != null)
                Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              if (_image == null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        PremedAssets.Payment,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                      Text('Upload the screenshot of the \nPayment Receipt',
                          textAlign: TextAlign.center,
                          style: PreMedTextTheme().body.copyWith(
                                color: PreMedColorTheme().black,
                              )),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBoxes.verticalMicro,
        SizedBox(
          width: 110,
          height: 50,
          child: TextButton(
            onPressed: _pickImage,
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(color: Colors.black, width: 2),
              ),
              backgroundColor: MaterialStateProperty.all(
                  PreMedColorTheme().primaryColorBlue500),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload',
                  style: PreMedTextTheme().small.copyWith(
                        color: PreMedColorTheme().white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 0.11,
                      ),
                ),
                SizedBoxes.horizontalMedium,
                Image.asset(PremedAssets.Paymentupload),
              ],
            ),
          ),
        ),
        SizedBoxes.verticalMedium
      ],
    );
  }
}
