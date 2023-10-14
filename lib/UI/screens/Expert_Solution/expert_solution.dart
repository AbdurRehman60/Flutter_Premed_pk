import 'dart:io';

import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/display_image_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/local_image_display.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/UI/Widgets/or_divider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';

import '../../../constants/premed_theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(ExpertSolution(camera: firstCamera));
// }

class ExpertSolution extends StatelessWidget {
  final File? image;
  const ExpertSolution({
    Key? key,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                SizedBoxes.horizontalExtraGargangua,
                SizedBoxes.horizontalExtraGargangua,
                Text(
                  'Ask an Expert',
                  style: PreMedTextTheme().heading6,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBoxes.verticalMedium,
                        Container(
                            height: 300,
                            // height: MediaQuery.sizeOf(context).height,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: ShapeDecoration(
                              color: PreMedColorTheme().neutral300,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            child: image != null
                                ? Expanded(
                                    child: Image.file(image!),
                                  )
                                : LocalImageDisplay()),
                        const OrDivider(),
                        SizedBoxes.verticalMedium,
                        CustomButton(
                            buttonText: 'Open Camera to take Pictures',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CameraScreen(),
                                ),
                              );
                            }),
                        SizedBoxes.verticalLarge,
                        Text(
                          'What problems are you facing in the uploaded question above? *',
                          style: PreMedTextTheme().subtext,
                        ),
                        SizedBoxes.verticalMedium,
                        CustomTextField(
                          maxLines: 6,
                          hintText: 'Enter questions here',
                        ),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select Resource',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        ResourceList(),
                        // ResourceList(),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'What subject is the question related to?',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        SizedBoxes.verticalMedium,
                        SubjectList(),
                        // SubjectList(),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select Topic',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        SizedBoxes.verticalMedium,
                        TopicList(),
                        SizedBoxes.verticalLarge,
                        CustomButton(buttonText: 'Submit', onPressed: () {}),
                        SizedBoxes.verticalMicro,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigator()
          ],
        ),
      ),
    );
  }
}

class ResourceList extends StatefulWidget {
  @override
  _ResourceListState createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
  String selectedValue = '--Select Resource--';

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItems = [
      '--Select Resource--',
      'MDCAT Past Papers',
      'NUMS Past Papers',
      'Olevels',
      'AS level',
      'A2 level',
      'FSC First Year',
      'FSC Secondd Year',
      'Others'
    ];

    return Center(
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
      ),
    );
  }
}

class SubjectList extends StatefulWidget {
  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  String selectedValue = '--Select Subject--';

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItems = [
      '--Select Subject--',
      'English',
      'Biology',
      'Chemistry',
      'Physics',
      'Mathematics',
      'Logical Reasoning',
      'Others'
    ];

    return Center(
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
      ),
    );
  }
}

class TopicList extends StatefulWidget {
  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  String selectedValue = '--Select Topic--';

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItems = [
      '--Select Topic--',
      'Introduction to Fundamental Concepts of Chemistry - NUMS',
      'Alcohols, Phenols and Ethers - NUMS',
      'Aldehydes and Ketones - NUMS',
      'Atomic Structure - NUMS',
      'Carboxyix Acids and its Derivatives - NUMS',
      'Chemical Bonding - NUMS',
      'Chemical Equilibrium - NUMS',
      'Fundamental Principles of Organic Chemistry - NUMS',
      'Hydrocarbons - NUMS'
    ];

    return Center(
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        value: selectedValue,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
      ),
    );
  }
}
