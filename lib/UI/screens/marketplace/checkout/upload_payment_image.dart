import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/select_upload_method_bottomsheet.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:provider/provider.dart';

class UploadPaymentImage extends StatefulWidget {
  const UploadPaymentImage({super.key});

  @override
  State<UploadPaymentImage> createState() => _UploadPaymentImageState();
}

class _UploadPaymentImageState extends State<UploadPaymentImage> {
  @override
  void initState() {
    Provider.of<UplaodImageProvider>(context, listen: false).initToNull();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uplaodImageProvider = Provider.of<UplaodImageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: uplaodImageProvider.uploadedImage != null
          ? Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(8.0),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.file(
                      uplaodImageProvider.uploadedImage!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Center(
                  child: Positioned(
                    child: SizedBox(
                      width: 128,
                      height: 36,
                      child: CustomButton(
                        buttonText: "Upload",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const UploadOptionsBottomSheet();
                            },
                          );
                        },
                        color: PreMedColorTheme().primaryColorBlue600,
                        isIconButton: true,
                        leftIcon: false,
                        iconSize: 20,
                        fontSize: 16,
                        icon: Icons.file_upload_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  PremedAssets.Payment,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
                SizedBoxes.verticalMedium,
                Text('Upload the screenshot of the Payment Receipt',
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().body.copyWith(
                          color: PreMedColorTheme().black,
                        )),
                SizedBoxes.verticalMedium,
                SizedBox(
                  width: 128,
                  height: 36,
                  child: CustomButton(
                    buttonText: "Upload",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const UploadOptionsBottomSheet();
                        },
                      );
                    },
                    color: PreMedColorTheme().primaryColorBlue600,
                    isIconButton: true,
                    leftIcon: false,
                    iconSize: 20,
                    fontSize: 16,
                    icon: Icons.file_upload_outlined,
                  ),
                ),
                SizedBoxes.verticalMedium
              ],
            ),
    );
  }
}
