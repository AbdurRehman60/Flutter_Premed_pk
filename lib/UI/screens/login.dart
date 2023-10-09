import 'package:premedpk_mobile_app/export.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Container(
              // padding: EdgeInsets.only(top: 40, left: 22, right: 24),
              height: 360,
              width: 359,
              decoration:
                  BoxDecoration(gradient: PreMedColorTheme().primaryGradient),
              child: Column(
                children: [
                  Container(
                      padding:
                          const EdgeInsets.only(top: 40, right: 22, left: 24),
                      child: Text(
                        'Sign Up to get Province wise Chapter guides for Free!',
                        style: PreMedTextTheme().heading3,
                        textAlign: TextAlign.center,
                      )),
                  Image.asset('assets/images/books.png'),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 24, left: 15, right: 253),
                  child: Image.asset('assets/images/PreMedLogo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 70),
                  child: Text(
                    'Welcome Back,',
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().heading1,
                    // selectionColor: PreMedColorTheme().standardwhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  child: Text(
                    'Ready to persue you medical Dreams?',
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().heading6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    'Sign in to continue your journey',
                    textAlign: TextAlign.left,
                    style: PreMedTextTheme().heading6,
                  ),
                ),
                SizedBoxes.verticalBig,
                const SizedBox(
                  width: 330,
                  child: CustomTextField(
                    labelText: 'E-mail*',
                    hintText: 'john.doe@gmail.com*',
                  ),
                ),
                SizedBoxes.verticalLarge,
                const SizedBox(
                  width: 330,
                  child: CustomTextField(
                    labelText: 'Enter Password*',
                    hintText: 'Password',
                  ),
                ),
                SizedBoxes.verticalLarge,
                SizedBox(
                  width: 330,
                  child: CustomButton(
                      buttonText: "Login",
                      onPressed: () {
                        // ignore: avoid_print
                        print('Button Clicked');
                      }),
                ),
                SizedBoxes.verticalLarge,
                Text(
                  'I forgot my password.',
                  style: PreMedTextTheme().heading6,
                ),
                SizedBoxes.verticalLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: PreMedTextTheme().subtext,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: PreMedColorTheme().primaryColorRed,
                            fontSize: 19,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0.13),
                      ),
                    )
                  ],
                ),
                SizedBoxes.verticalLarge,
                const Text(
                  '----------------------------OR--------------------------',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBoxes.horizontalLarge,
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Sign in with google')),
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
