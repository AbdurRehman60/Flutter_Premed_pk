import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../constants/constants_export.dart';
// Import your text theme

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBoxes.verticalMedium,
                  Center(
                    child: GradientText(
                      'PreMed.PK Bundles',
                      style: PreMedTextTheme().heading3,
                      colors: [
                        PreMedColorTheme().primaryColorBlue,
                        PreMedColorTheme().primaryColorRed,
                      ],
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  CountdownTimerWidget(),
                  SizedBoxes.verticalBig,
                  SpecialOffers(),
                  SizedBoxes.verticalBig,
                ],
              ),
            ),
            MarketplaceTabView(),
          ],
        ),
      ),
    );
  }
}
