import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/thankyou_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_signup_flow/additional_info.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final buttonSize = MediaQuery.of(context).size.width * 0.7;

    void onLoginPressed() {
      final Future<Map<String, dynamic>> response1 = auth.continueWithGoogle();
      response1.then(
        (response) {
          if (response['status']) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => response['message'] == 'OnboardingOne'
                    ? const AdditionalInfo()
                    : const MainNavigationScreen(),
              ),
              (Route<dynamic> route) => false,
            );
            print('google result : ${response['message']}');
            final String lastOnboardingPage =
                response['user']['info']['lastOnboardingPage'];
            print(
                "this si the last onbaording url when ggllogin $lastOnboardingPage");
            if (lastOnboardingPage == "/auth/onboarding") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdditionalInfo()),
              );
            } else if (lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-medical/additional-info/features") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen()),
              );
            } else if (lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-medical/features/thankyou") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ThankyouScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdditionalInfo()),
              );
            }
          } else {
            showError(context, response);
          }
        },
      );
    }

    return SizedBox(
      width: buttonSize,
      height: 50,
      child: ElevatedButton(
        onPressed: onLoginPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: PreMedColorTheme().white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                PremedAssets.GoogleLogo,
                height: 24.0,
                width: 24.0,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Text(
                  'Continue with Google',
                  textAlign: TextAlign.center,
                  style: PreMedTextTheme().subtext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
