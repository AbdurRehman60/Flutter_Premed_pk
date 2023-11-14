import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class MarketPlace extends StatelessWidget {
  MarketPlace({Key? key});

  // Dummy data for the horizontal ListView
  final List<String> dummyData = List.generate(5, (index) => 'Offer $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PreMed.PK Bundles',
                  style: PreMedTextTheme().heading3.copyWith(
                        color: PreMedColorTheme().primaryColorRed,
                      ),
                ),
              ],
            ),
            const Text('Timer widget here'),
            const Text(
              'Special Offers',
              textAlign: TextAlign.left,
            ),
            // Horizontal ListView
            SizedBox(
              height: 275, // Adjust the height as needed
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 235,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: PreMedColorTheme().primaryColorBlue500,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                dummyData[index],
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              height: 50,
                              child: CustomButton(
                                buttonText: 'Buy Now ->',
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Scrollable Tab Bar
            Expanded(
              child: MarketplaceTabView(),
            ),
          ],
        ),
      ),
    );
  }
}
