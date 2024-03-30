import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'customised_buttons/qbank_button_t.dart';

class QbankTopical extends StatefulWidget {
  const QbankTopical({super.key});

  @override
  State<QbankTopical> createState() => _QbankTopicalState();
}

class _QbankTopicalState extends State<QbankTopical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "MDCAT QBANK",
                  style: PreMedTextTheme()
                      .heading1
                      .copyWith(color: PreMedColorTheme().black),
                ),
              ),
              ButtonRow(),
              SizedBoxes.verticalBig,
              Center(
                child: Text(
                    "Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!",
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().black)),
              ),
              SizedBoxes.verticalMedium,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation:3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PreMedColorTheme().white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage('assets/images/english.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENGLISH",
                                    style: PreMedTextTheme().heading4,),
                                  SizedBoxes.verticalMicro,
                                  Text("6 Topics",
                                    style: PreMedTextTheme().subtext,),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180, // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical2Px,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation:3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PreMedColorTheme().white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage('assets/images/english.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENGLISH",
                                    style: PreMedTextTheme().heading4,),
                                  SizedBoxes.verticalMicro,
                                  Text("6 Topics",
                                    style: PreMedTextTheme().subtext,),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180, // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical2Px,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation:3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PreMedColorTheme().white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage('assets/images/english.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENGLISH",
                                    style: PreMedTextTheme().heading4,),
                                  SizedBoxes.verticalMicro,
                                  Text("6 Topics",
                                    style: PreMedTextTheme().subtext,),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180, // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical2Px,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation:3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PreMedColorTheme().white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage('assets/images/english.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENGLISH",
                                    style: PreMedTextTheme().heading4,),
                                  SizedBoxes.verticalMicro,
                                  Text("6 Topics",
                                    style: PreMedTextTheme().subtext,),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180, // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical2Px,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation:3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PreMedColorTheme().white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage('assets/images/english.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ENGLISH",
                                    style: PreMedTextTheme().heading4,),
                                  SizedBoxes.verticalMicro,
                                  Text("6 Topics",
                                    style: PreMedTextTheme().subtext,),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180, // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MDCAT()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}