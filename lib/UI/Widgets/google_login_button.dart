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
    AuthProvider auth = Provider.of<AuthProvider>(context);
    onLoginPressed() {
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

    return GestureDetector(
      onTap: onLoginPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: PreMedColorTheme()
                .primaryColorRed, // Change the outline color as needed
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              PremedAssets
                  .GoogleLogo, // Replace with the path to your Google logo image
              height: 24.0,
              width: 24.0,
            ),
            SizedBoxes.horizontalMedium,
            Text(
              'Continue with Google',
              style: PreMedTextTheme().subtext,
            ),
          ],
        ),
      ),
    );
  }
}
