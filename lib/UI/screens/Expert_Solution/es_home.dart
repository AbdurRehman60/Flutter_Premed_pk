import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/export.dart';

class EsHome extends StatelessWidget {
  EsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 220,
              width: MediaQuery.sizeOf(context).width,
              decoration: ShapeDecoration(
                  gradient: PreMedColorTheme().primaryGradient1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/eshome.png'),
                        SizedBoxes.horizontalMedium,
                        Text(
                          'Expert Solution',
                          style: PreMedTextTheme()
                              .heading5
                              .copyWith(color: PreMedColorTheme().white),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalBig,
                    Text(
                      'Get top-notch video solution answers to your',
                      style: PreMedTextTheme()
                          .subtext
                          .copyWith(color: PreMedColorTheme().white),
                    ),
                    Text(
                      'MDCAT questions from top-merit experts',
                      style: PreMedTextTheme()
                          .subtext
                          .copyWith(color: PreMedColorTheme().white),
                    ),
                    SizedBoxes.verticalBig,
                    Expanded(child: CustomTabBar())
                  ],
                ),
              ),
            ),
            Container(
              height: 480,
              width: MediaQuery.sizeOf(context).width,
              color: PreMedColorTheme().white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: PreMedColorTheme().primaryColorRed,
                        foregroundColor: PreMedColorTheme().white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RequiredOnboarding(),
                            ),
                          );
                        },
                        tooltip: 'Move to next screen',
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigator()
          ],
        ),
      ),
    );
  }
}
