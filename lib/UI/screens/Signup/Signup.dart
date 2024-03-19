import 'package:premedpk_mobile_app/UI/screens/signup/widgets/signup_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120,),
              const SignupForm()
            ],
          ),
        ),
      ),
    );
  }
}
