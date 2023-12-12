import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Thankyou extends StatelessWidget {
  const Thankyou({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              PremedAssets.Celebration,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  PremedAssets.Purchase,
                  width: 132,
                  height: 132,
                  fit: BoxFit.fill,
                ),
                GradientText(
                  'Thank You!',
                  style: PreMedTextTheme().heading1.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  colors: [
                    PreMedColorTheme().primaryColorBlue,
                    PreMedColorTheme().primaryColorRed
                  ],
                ),
                SizedBoxes.verticalTiny,
                Text(
                  'Your order will be processed \nin 1-2 hours.',
                  style: PreMedTextTheme().body.copyWith(
                        color: PreMedColorTheme().neutral600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: CustomButton(
                  buttonText: 'Home ->',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
