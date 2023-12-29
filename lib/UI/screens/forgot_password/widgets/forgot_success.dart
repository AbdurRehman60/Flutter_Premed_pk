import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(
                    0xFFDDF6E9), // Set your desired background color
                borderRadius: BorderRadius.circular(12.0), // Set border radius
                border: Border.all(
                  color: const Color(0xFF153424), // Set border color
                  width: 0, // Set border thickness
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        PremedAssets.Check,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBoxes.horizontalMicro,
                      const Text(
                        'Success',
                        style: TextStyle(
                          color: Color(0xFF153424),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  const Text(
                    'Recovery instructions have \nbeen sent to your email, you \ncan safely close this tab',
                    style: TextStyle(
                      color: Color(0xFF153424),
                      fontSize: 16.0,
                    ),
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
