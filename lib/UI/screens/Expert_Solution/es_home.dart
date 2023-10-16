import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/export.dart';

class EsHome extends StatelessWidget {
  const EsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 232,
              width: MediaQuery.sizeOf(context).width,
              decoration: ShapeDecoration(
                  gradient: PreMedColorTheme().primaryGradient,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(PremedAssets.EsIcon),
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
                          'Get top-notch video solution answers to your MDCAT questions from top-merit experts',
                          style: PreMedTextTheme()
                              .subtext
                              .copyWith(color: PreMedColorTheme().white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxes.verticalBig,
                      ],
                    ),
                  ),
                  CustomTabBar()
                ],
              ),
            ),
            // Container(
            //   height: 480,
            //   width: MediaQuery.sizeOf(context).width,
            //   color: PreMedColorTheme().white,
            //   child: Padding(
            //     padding: EdgeInsets.all(16),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Align(
            //           alignment: Alignment.bottomRight,
            //           child:
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // mini: true,
          isExtended: true,
          backgroundColor: PreMedColorTheme().primaryColorRed,
          foregroundColor: PreMedColorTheme().white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpertSolution(),
              ),
            );
          },
          tooltip: 'Expert Solution',
          child: const Icon(
            size: 35,
            Icons.add,
          ),
        ));
  }
}
