// ignore_for_file: non_constant_identifier_names

import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Privacy Policy',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black, // Set the color for the icon
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'In this privacy policy, “you” or “your” refers to any person or entity subscribing to and/or using the Service (“Users”). Unless otherwise stated, “PreMed.PK,” “we,” or “our” will refer collectively to www.premed.pk. \n\nPlease review this privacy policy carefully. By using PreMed.PK, you acknowledge that you accept the privacy policies and practices set forth herein. We are aware of the importance and sensitivity of your data and thank you for your trust. If you have any individual questions, please do not hesitate to contact us at contact@premed.pk. \n\nThis Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in PreMed.PK. This policy is not applicable to any information collected offline or via channels other than this website.',
              ),
              SizedBoxes.verticalBig,
              Text(
                'INFORMATION WE COLLECT',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information. \nIf you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide. \nWhen you register for an Account, we may ask for your contact information, including items such as name, college name, email address, and telephone number.',
              ),
              SizedBoxes.verticalBig,
              Text(
                'HOW WE USE YOUR INFORMATION',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              // Manually create Text widgets for bullet points
              for (final String bulletPoint in howWeUseYourInformationBulletPoints)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                            fontSize: 16), // You can adjust the font size
                      ),
                      Expanded(
                        child: Text(bulletPoint),
                      ),
                    ],
                  ),
                ),
              SizedBoxes.verticalBig,
              Text(
                'COOKIES AND WEB BEACONS',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                "Like any other website, PreMed.PK uses 'cookies'. These cookies are used to store information including visitors' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users' experience by customizing our web page content based on visitors' browser type and/or other information.",
              ),
              SizedBoxes.verticalBig,
              Text(
                'THIRD PARTY PRIVACY POLICIES',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                "PreMed.PK's Privacy Policy does not apply to other advertisers or websites. Thus, we advise you to consult the respective Privacy Policies of these third-party ad servers for more detailed information.",
              ),
              SizedBoxes.verticalBig,
              Text(
                'SECURITY OF YOUR INFORMATION',
                style: PreMedTextTheme().heading5,
              ),
              const Text(
                'We take steps designed to secure your information from unauthorized access or use. Unfortunately, no method of transmission over the Internet can be guaranteed to be 100% secure, and we cannot guarantee the security of any information you provide to us. By using PreMed.PK or providing Personal Information to us, you agree that we may communicate with you electronically regarding security, privacy, and administrative issues relating to your use of PreMed.PK',
              ),
              Text(
                'DMCA Guidelines',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalBig,
              for (final String bulletPoint in DMCAGuidlines)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                            fontSize: 16), // You can adjust the font size
                      ),
                      Expanded(
                        child: Text(bulletPoint),
                      ),
                    ],
                  ),
                ),
              SizedBoxes.verticalBig,
              Text(
                'YOUR RIGHTS OVER YOUR INFORMATION AND QUESTIONS OR SUGGESTIONS',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'If you would like to access, correct or ask us to restrict our processing or delete any Personal Information that you have provided to us through your use of PreMed.PK or otherwise, or if you have suggestions for improving this Privacy Policy, please send an email to contact@premed.pk',
              ),
              SizedBoxes.verticalBig,
              Text(
                'CHANGES TO OUR PRIVACY POLICY AND PRACTICES',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'We will post any adjustments to the Privacy Policy on this web page, and the revised version will be effective when it is posted. We encourage users to frequently check this page for any changes to stay informed about how we are protecting their information.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define your bullet points outside the widget
List<String> howWeUseYourInformationBulletPoints = [
  'Provide, operate, and maintain our website',
  'Improve, personalize, and expand our website',
  'Develop new products, services, features, and functionality',
  'Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes',
  'Send you emails',
  'Find and prevent fraud',
];

List<String> DMCAGuidlines = [
  'Delete Data: You can ask us to erase or delete all or some of your personal data (e.g., if it is no longer necessary to provide Services to you)',
  "Change or Correct Data: You can edit your personal data through your account. You can also ask us to change, update or fix your data in certain cases, particularly if it's inaccurate. To initiate any of these processes, please email contact@premed.pk from the email account associated with your PreMed.PK account."
];
