import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/pre_eng/screens/estuff_home.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/pre_eng/screens/study_notes_home_eng.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import '../../vault_home.dart';
import '../widgets/estuff_reel.dart';
import '../widgets/study_notes_reel.dart';

class PreEngVaultHome extends StatefulWidget {
  const PreEngVaultHome({super.key});

  @override
  State<PreEngVaultHome> createState() => _VaultHomeState();
}

class _VaultHomeState extends State<PreEngVaultHome> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkSubscription());
  }

  void checkSubscription() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accessProvider =
    Provider.of<PreEngAccessProvider>(context, listen: false);
    accessProvider.setSubscriptions(userProvider.user!.access);
    accessProvider.updateAccessFlags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Pre',
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800, fontSize: 15)),
                            TextSpan(
                                text: 'M',
                                style: PreMedTextTheme().heading1.copyWith(
                                    color: PreMedColorTheme().primaryColorRed,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15)),
                            TextSpan(
                                text: 'ed',
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800, fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    SizedBoxes.vertical3Px,
                    SvgPicture.asset(
                      'assets/images/vault/Only Vault.svg',
                      height: 41,
                    ),
                    SizedBoxes.vertical3Px,
                    Text(
                        'All The Resources Any Pre Engineering Student Could Ever Need',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 17)),
                    SizedBoxes.vertical26Px,
                    Row(
                      children: [
                        GradientButton(
                            text: 'Essential Stuff',
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFF44009B),
                                Color(0xFF2370CA),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EstuffNotesHome()));
                            }),
                        SizedBoxes.horizontal10Px,
                        GradientButton(
                            text: 'Study Notes',
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFF80239F),
                                Color(0xFFB43483),
                                Color(0xFFFE8B83)
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const EngineeringStudyNotesHome()));
                            }),
                        SizedBoxes.horizontal10Px,
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBoxes.vertical26Px,
                          Row(
                            children: [
                              const GradientText(
                                text: 'Essential',
                                fontSize: 18,
                              ),
                              Text(' Stuff',
                                  style: PreMedTextTheme().heading1.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstuffNotesHome()));
                                  //To Navigate
                                },
                                child: Text('View All',
                                    style: PreMedTextTheme().heading1.copyWith(
                                        color: const Color(0xFF3F83F8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                          Text(
                            'Syllabi, Schemes, etc., and everything a student just needs.',
                            style: PreMedTextTheme().heading1.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                          ),
                          SizedBoxes.vertical10Px,

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 83,
                      child: const EngEstuffPage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(top: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/vault/stn.svg'),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // To Navigate
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EngineeringStudyNotesHome()));
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12, right: 5),
                                      child: Text('View All',
                                          style: PreMedTextTheme()
                                              .heading1
                                              .copyWith(
                                                  color:
                                                      const Color(0xFF3F83F8),
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                            top: 30,
                            left: 8,
                            child: Text(
                              'The most comprehensive notes in town.',
                              style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ))
                      ],
                    ),
                    // First Section
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 7),
                child: SizedBox(
                    height: 83,
                    child: const PreEngStudyNotesPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
