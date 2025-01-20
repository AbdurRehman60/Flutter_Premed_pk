import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../The vault/widgets/back_button.dart';

class ForgotPasswordError extends StatelessWidget {
  const ForgotPasswordError({super.key, required this.errorText});
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background ,
      // PreMedColorTheme().background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar( centerTitle: false,
          backgroundColor: PreMedColorTheme().background,
          leading: const PopButton(),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel_outlined,
                    color: PreMedColorTheme().primaryColorRed,
                    size: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBoxes.horizontalMicro,
                      const Text(
                        'Error',
                        style: TextStyle(
                          color: Color(0xFF341515),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMicro,
                  Text(
                      errorText,
                      style: PreMedTextTheme(
                      ).subtext1.copyWith(
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.normal
                      )
                  ),
                  SizedBoxes.verticalBig,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note',
                          style: PreMedTextTheme().subtext.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: PreMedColorTheme().black,
                          ),
                        ),
                        TextSpan(
                          text:
                          ', you will only receive an email if you have a PreMed account.',
                          style: PreMedTextTheme().subtext.copyWith(
                            fontStyle: FontStyle.italic,
                            color: PreMedColorTheme().black,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}