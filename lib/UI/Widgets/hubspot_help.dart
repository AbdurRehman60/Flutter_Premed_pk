import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:url_launcher/url_launcher.dart';

class HubspotHelpButton extends StatelessWidget {
  const HubspotHelpButton({
    super.key,
    this.light = false,
  });
  final bool light;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        launchUrl(
          mode: LaunchMode.inAppBrowserView,
          Uri.parse('https://premed.pk/support'),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat,
            color: light
                ? PreMedColorTheme().white
                : PreMedColorTheme().neutral500,
            size: 20,
          ),
          SizedBoxes.horizontalTiny,
          Text(
            "Need Help? Chat with us.",
            style: PreMedTextTheme().subtext.copyWith(
                  color: light
                      ? PreMedColorTheme().white
                      : PreMedColorTheme().neutral500,
                ),
          )
        ],
      ),
    );
  }
}
