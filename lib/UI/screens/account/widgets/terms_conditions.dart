// ignore_for_file: non_constant_identifier_names

import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../The vault/widgets/back_button.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        leading: const PopButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Condition',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to PreMed.PK! \n\nThese terms and conditions outline the rules and regulations for the use of PreMed.PK's Website, located at premed.pk. \n\nBy accessing this website we assume you accept these terms and conditions. Do not continue to use PreMed.PK if you do not agree to take all of the terms and conditions stated on this page. The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company’s terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same",
              ),
              SizedBoxes.verticalBig,
              Text(
                'Cookies',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                "We employ the use of cookies. By accessing PreMed.PK, you agreed to use cookies in agreement with the PreMed.PK's Privacy Policy. \nMost interactive websites use cookies to let us retrieve the user’s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies",
              ),
              SizedBoxes.verticalBig,
              Text(
                'License',
                style: PreMedTextTheme().heading5,
              ),
              const Text(
                'Unless otherwise stated, PreMed.PK and/or its licensors own the intellectual property rights for all material on PreMed.PK. All intellectual property rights are reserved. You may access this from PreMed.PK for your own personal use subjected to restrictions set in these terms and conditions.\nYou Must Not:',
              ),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in License)
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
                'Hyperlinking to Our Content',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                  'The following organizations may link to our Website without prior written approval:'),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in Hyperlinking)
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
              const Text(
                  'These organizations may link to our home page, to publications, or to other Website information so long as the link:'),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in Hyperlinking1)
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
              const Text(
                'We may consider and approve other link requests from the following types of organizations:',
              ),
              for (final String bulletPoint in Hyperlinking2)
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
              const Text(
                'We will approve link requests from these organizations if we decide that:',
              ),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in Hyperlinking3)
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
              const Text(
                  'These organizations may link to our home page so long as the link:'),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in Hyperlinking4)
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
              const Text(
                'If you are one of the organizations listed above and are interested in linking to our website, you must inform us by sending an e-mail to PreMed.PK. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.',
              ),
              SizedBoxes.verticalMedium,
              const Text(
                  'Approved organizations may hyperlink to our Website as follows:'),
              SizedBoxes.verticalMedium,
              for (final String bulletPoint in Hyperlinking5)
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
              const Text(
                "No use of PreMed.PK's logo or other artwork will be allowed for linking absent a trademark license agreement.",
              ),
              Text(
                'Reservation of Rights',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amend these terms and conditions and it’s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.',
              ),
              SizedBoxes.verticalBig,
              Text(
                'We are not obligated to do so or to respond to you directly',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.',
              ),
              SizedBoxes.verticalBig,
              Text(
                'DMCA Guidelines',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              const Text(
                'In accordance with the Digital Millennium Copyright Act or DMCA, PreMed.PK encourages all copyright infringement claims to be made in writing. Any registered user or visitor to the PreMed.PK website who believes they are a victim of copyright infringement should notify us immediately at contact@premed.pk with the subject of DMCA.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> License = [
  'Republish material from PreMed.PK',
  'Sell, rent or sub-license material from PreMed.PK',
  'Reproduce, duplicate or copy material from PreMed.PK',
  'Redistribute content from PreMed.PK',
  'Share your password with any third parties unauthorized purpose',
];
List<String> Hyperlinking = [
  'Government agencies;',
  'Search engines;',
  'News organizations;',
  'Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and',
  'System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.',
];
List<String> Hyperlinking1 = [
  'is not in any way deceptive;',
  'does not falsely imply sponsorship, endorsement, or approval of the linking party and its products and/or services; and',
  "fits within the context of the linking party’s site.",
];
List<String> Hyperlinking2 = [
  'Commonly-known consumer and/or business information sources;',
  'Dot.com community sites;',
  'Associations or other groups representing charities;',
  'Online directory distributors;',
  'Internet portals;',
  'Accounting, law, and consulting firms; and',
  'Educational institutions and trade associations.',
];
List<String> Hyperlinking3 = [
  'the link would not make us look unfavorably to ourselves or to our accredited businesses;',
  'the organization does not have any negative records with us;',
  'the benefit to us from the visibility of the hyperlink compensates the absence of PreMed.PK; and',
  'the link is in the context of general resource information.',
];
List<String> Hyperlinking4 = [
  'is not in any way deceptive;',
  'does not falsely imply sponsorship, endorsement, or approval of the linking party and its products or services; and',
  "fits within the context of the linking party’s site.",
];
List<String> Hyperlinking5 = [
  'By use of our corporate name; or',
  'By use of the uniform resource locator being linked to; or',
  "By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party’s site.",
];
