import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../constants/constants_export.dart';
// Import your text theme

class MarketPlace extends StatelessWidget {
  MarketPlace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GradientText('PreMed.PK Bundles',
                style: PreMedTextTheme().heading3,
                colors: [
                  PreMedColorTheme().primaryColorBlue,
                  PreMedColorTheme().primaryColorRed,
                ]),
            SizedBoxes.verticalMedium,
            Center(
              child: CountdownTimerWidget(),
            ),
            SizedBoxes.verticalMedium,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Special Offers', // Display the current tab name (you can modify this as needed)
                  textAlign: TextAlign.left,
                  style: PreMedTextTheme().subtext,
                ),
              ),
            ),
            SpecialOffers(),
            SizedBoxes.verticalMedium,
            MarketplaceTabView(),
          ],
        ),
      ),
    );
  }
}
