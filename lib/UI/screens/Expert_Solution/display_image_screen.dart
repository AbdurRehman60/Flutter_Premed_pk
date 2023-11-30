import 'dart:io';

import 'package:premedpk_mobile_app/UI/screens/expert_solution/crop.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';

import 'package:provider/provider.dart';

class DisplayImageScreen extends StatelessWidget {
  final File image;

  DisplayImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uplaodImageProvider = Provider.of<UplaodImageProvider>(context);

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
                    Navigator.of(context).pop();
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
                    uplaodImageProvider.uploadedImage = image;
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
