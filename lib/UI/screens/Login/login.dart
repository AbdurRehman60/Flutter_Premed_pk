import 'package:premedpk_mobile_app/UI/screens/login/widgets/login_form.dart';
import 'package:premedpk_mobile_app/UI/widgets/freenotes_animation.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  gradient: PreMedColorTheme().primaryGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TypingTextAnimation()),
                    SizedBoxes.verticalBig,
                    Image.asset('assets/images/Books.png'),
                  ],
                ),
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
