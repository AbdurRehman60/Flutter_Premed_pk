import '../../export.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  .PrMedLogo, // Replace with the path to your Google logo image
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
