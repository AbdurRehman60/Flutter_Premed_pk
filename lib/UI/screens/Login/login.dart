import 'package:premedpk_mobile_app/UI/screens/Login/animation.dart';
import 'package:premedpk_mobile_app/UI/screens/login/widgets/login_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().white,
                  ),
                  child: const MovingRowAnimation()),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
