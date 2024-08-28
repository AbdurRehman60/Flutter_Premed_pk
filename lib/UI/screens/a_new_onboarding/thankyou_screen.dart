import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/user_provider.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key, this.password});

  final String? password;

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  String encrypt(String text, String key) {
    final textBytes = utf8.encode(text);
    final keyBytes = utf8.encode(key);
    final encryptedBytes = List<int>.generate(textBytes.length, (i) {
      return textBytes[i] ^ keyBytes[i % keyBytes.length];
    });

    return base64Url.encode(encryptedBytes);
  }

  String decrypt(String encryptedText, String key) {
    final encryptedBytes = base64Url.decode(encryptedText);
    final keyBytes = utf8.encode(key);
    final decryptedBytes = List<int>.generate(encryptedBytes.length, (i) {
      return encryptedBytes[i] ^ keyBytes[i % keyBytes.length];
    });

    return utf8.decode(decryptedBytes);
  }

  Future<void> _launchURL(String username, String encryptedPassword) async {
    final url =
        'https://premed.pk/app-redirect?username="$username"&&password="$encryptedPassword"==&&route="pricing/all"';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String username = userProvider.user?.userName ?? '';
    final String password = widget.password ?? '';
    final String encryptedPassword = encrypt(password, 'PreMedIsNotParho');

    print("Username: $username, Password: ${widget.password}, Encrypted Password: $encryptedPassword");

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              PremedAssets.Celebration,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  PremedAssets.Purchase,
                  width: 132,
                  height: 132,
                  fit: BoxFit.fill,
                ),
                GradientText(
                  'Thank You!',
                  style: PreMedTextTheme().heading1.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  colors: [
                    PreMedColorTheme().primaryColorBlue,
                    PreMedColorTheme().primaryColorRed
                  ],
                ),
                SizedBoxes.verticalTiny,
                Text(
                  'You will now be redirected to the web',
                  style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: CustomButton(
                  buttonText: 'Home ->',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationScreen(userPassword: password),
                      ),
                    );
                    _launchURL(username, encryptedPassword);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
