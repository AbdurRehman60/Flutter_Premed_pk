import 'dart:io';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/camera_widget.dart';
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
        title: Text('Crop Picture'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.file(image),
          ),
          CustomButton(
              buttonText: 'capture again',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => ExpertSolution(image: image)),
                );
              })
        ],
      ),
    );
  }
}
