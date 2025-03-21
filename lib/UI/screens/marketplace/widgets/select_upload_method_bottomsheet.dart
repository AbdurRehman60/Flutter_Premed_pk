import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/utils/services/open_gallery.dart';

class UploadOptionsBottomSheet extends StatelessWidget {
  const UploadOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 124,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                pickImage();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.filter_outlined),
                  SizedBoxes.verticalTiny,
                  const Text("Upload from gallery")
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined),
                  SizedBoxes.verticalTiny,
                  const Text("Upload from Camera")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
