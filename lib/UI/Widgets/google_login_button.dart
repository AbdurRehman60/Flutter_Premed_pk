import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => response['message'] == 'onboarding'
                    ? const RequiredOnboarding()
                    : const MainNavigationScreen(),
              ),
            );
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
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                PremedAssets.GoogleLogo,
                height: 24.0,
                width: 24.0,
                fit: BoxFit.contain,
              ),
              // SizedBoxes.horizontalMedium,
              Expanded(
                child: Text(
                  'Sign In with Google',
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