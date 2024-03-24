import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_qbank_mocks.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_qbank_yearly.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MDCAT extends StatefulWidget {
  const MDCAT({super.key});

  @override
  State<MDCAT> createState() => _MDCATState();
}

class _MDCATState extends State<MDCAT> {
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
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                child: Text(
                  "MDCAT",
                  style: PreMedTextTheme()
                      .heading1
                      .copyWith(color: PreMedColorTheme().black),
                ),
              ),

              //SizedBoxes.verticalTiny,
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                  child: Text(
                      "Past Papers, Mocks and Original Practice Questions",
                      textAlign: TextAlign.start,
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
                        elevation: 3,
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
                                backgroundImage: AssetImage(
                                    'assets/images/MDCAT QBank 2.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MDCAT Question\nBank",
                                    style: PreMedTextTheme().heading4,
                                  ),
                                  SizedBoxes.verticalMicro,
                                  Text(
                                    "4 Papers",
                                    style: PreMedTextTheme().subtext,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180,
                                // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,
                                  ),
                                  onPressed: () {

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QbankYearly()));
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
                        elevation: 3,
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
                                backgroundImage: AssetImage(
                                    'assets/images/MDCAT QBank 2.png'),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MOCKS",
                                    style: PreMedTextTheme().heading4,
                                  ),
                                  SizedBoxes.verticalMicro,
                                  Text(
                                    "4 Papers",
                                    style: PreMedTextTheme().subtext,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.rotate(
                                angle: -180 * 3.141592653589793 / 180,
                                // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: PreMedColorTheme().primaryColorRed,
                                  ),
                                  onPressed: () {

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QbankMocks()));
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
