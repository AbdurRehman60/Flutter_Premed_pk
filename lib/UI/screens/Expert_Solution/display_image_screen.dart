import 'dart:io';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/crop_image.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PreMedColorTheme().white,
        leading: IconButton(
          color: PreMedColorTheme().black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle the back button as needed
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Crop Photo',
          style: PreMedTextTheme()
              .subtext
              .copyWith(color: PreMedColorTheme().black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Expanded(
              child: Image.file(image),
            ),
          ),
          SizedBoxes.verticalMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CameraScreen(),
                  ));
                },
                icon: Icon(Icons.cancel),
                iconSize: 42,
                alignment: Alignment.bottomLeft,
                color: PreMedColorTheme().primaryColorRed,
              ),
              SizedBox(
                width: 230,
                child: CustomButton(
                  buttonText: 'Continue to Crop Image',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CropImageScreen(),
                        settings: RouteSettings(
                          arguments: image, // Pass the image as an argument
                        ),
                      ),
                    );
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
                icon: Icon(Icons.check),
                iconSize: 42,
                color: PreMedColorTheme().primaryColorRed,
              )
            ],
          ),
          SizedBoxes.verticalMedium
        ],
      ),
    );
  }
}
