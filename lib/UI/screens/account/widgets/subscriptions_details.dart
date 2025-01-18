import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../The vault/widgets/back_button.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  Future<void> _launchURL(String appToken) async {
    final url =
        'https://premed.pk/app-redirect?url=$appToken&&route="/"';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String appToken = userProvider.user?.info.appToken ?? '';
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
            leading: const PopButton(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Subscriptions',
                  style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBoxes.vertical3Px,
                Text(
                  'OVERVIEW',
                  style: PreMedTextTheme().subtext.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: PreMedColorTheme().black,
                      ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  _launchURL(appToken);
                },
                child: Container(
                  height: 25,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().red
                          : PreMedColorTheme().blue,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 100,
                          offset: Offset(0, 20),
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      'To PreMed Shop',
                      style: PreMedTextTheme().subtext.copyWith(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubscriptionCard(),
              SizedBoxes.vertical15Px,
              Text(
                'Details',
                style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBoxes.vertical15Px,
              SubscriptionDetailSection(
                title: 'MDCAT',
                items: [
                  DetailItem(
                      isAvailable: true,
                      label: 'Chapter-Wise MCQs',
                      onTap: () {}),
                  DetailItem(
                      isAvailable: true,
                      label: 'Past-Paper MCQs',
                      onTap: () {}),
                  DetailItem(
                      isAvailable: true, label: 'Weekly Tests', onTap: () {}),
                  DetailItem(
                      isAvailable: false,
                      label: 'Self-Assessment Mocks',
                      onTap: () {
                        _launchURL(appToken);
                      }),
                  DetailItem(
                      isAvailable: false,
                      label: 'Test Sessions',
                      onTap: () {
                        _launchURL(appToken);
                      }),
                ],
              ),
              SizedBoxes.verticalBig,
              SubscriptionDetailSection(
                title: 'NUMS',
                items: [
                  DetailItem(
                      isAvailable: true,
                      label: 'Chapter-Wise MCQs',
                      onTap: () {}),
                  DetailItem(
                      isAvailable: true,
                      label: 'Past-Paper MCQs',
                      onTap: () {}),
                  DetailItem(
                      isAvailable: false,
                      label: 'Weekly Tests',
                      onTap: () {
                        _launchURL(appToken);
                      }),
                  DetailItem(
                      isAvailable: true,
                      label: 'Self-Assessment Mocks',
                      onTap: () {}),
                  DetailItem(
                      isAvailable: true, label: 'Test Sessions', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    int calculateRemainingDays(DateTime endDate) {
      final now = DateTime.now();
      return endDate.difference(now).inDays;
    }

    final category = userProvider.subscriptions[0].name;
    final remainingDays = calculateRemainingDays(
        userProvider.subscriptions[0].subscriptionEndDate);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    PremedAssets.crown,
                    height: 30,
                    width: 36,
                  ),
                  SizedBoxes.horizontalTiny,
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFFE8383),
                          Color(0xFFB43453),
                          Color(0xFFFF4B81)
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ).createShader(bounds),
                      child: const Text(
                        'Ultimate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBoxes.verticalMicro,
              Text(
                category,
                style: PreMedTextTheme().subtext.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (userProvider.subscriptions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF77D9A5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF076445),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF77D9A5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'NOT ACTIVE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF076445),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              SizedBoxes.verticalTiny,
              Text(
                "ACCESS ENDS IN $remainingDays DAYS",
                style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().red
                          : PreMedColorTheme().blue,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SubscriptionDetailSection extends StatelessWidget {
  const SubscriptionDetailSection({
    super.key,
    required this.title,
    required this.items,
  });
  final String title;
  final List<DetailItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBoxes.vertical10Px,
          Column(
            children: items.map((item) => item).toList(),
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem(
      {super.key,
      required this.isAvailable,
      required this.label,
      required this.onTap});
  final bool isAvailable;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Image.asset(
            isAvailable ? PremedAssets.subCheck : PremedAssets.subWrong,
            height: 20,
            width: 20,
          ),
          SizedBoxes.horizontalMedium,
          Text(
            label,
            style: TextStyle(
              color: isAvailable
                  ? const Color(0xFF00AC51)
                  : const Color(0xFFEC5863),
              fontWeight: isAvailable ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          if (!isAvailable)
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  backgroundColor: Provider.of<PreMedProvider>(context).isPreMed
                      ? PreMedColorTheme().red
                      : PreMedColorTheme().blue,
                  foregroundColor: Colors.white),
              child: const Text('Get Now'),
            ),
        ],
      ),
    );
  }
}
