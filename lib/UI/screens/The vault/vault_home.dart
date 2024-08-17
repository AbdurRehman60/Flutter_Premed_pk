import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/estuff_home.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/mnemonics_home.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/shortlistings.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/studynotes.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/topical_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/essence_stuff_builder.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/guides_or_notes_page.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/mnemonics/mnemonics_reel_builder.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/shortlistings_note_page.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/essential_stuff_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/vaultProviders/premed_access_provider.dart';

class VaultHome extends StatefulWidget {
  const VaultHome({super.key});

  @override
  State<VaultHome> createState() => _VaultHomeState();
}

class _VaultHomeState extends State<VaultHome> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void getStuff() {
    final est = Provider.of<EssentialStuffProvider>(context);
    est.getEssentialStuff();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkSubscription());
  }

  void checkSubscription() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final accessProvider =
        Provider.of<PreMedAccessProvider>(context, listen: false);
    accessProvider.setSubscriptions(userProvider.user!.access);
    accessProvider.checkAccess();
  }
  //
  // void checkSubscription() {
  //   final userPurchases =
  //       Provider.of<UserProvider>(context, listen: false).user?.access;
  //   if (userPurchases != null) {
  //     Provider.of<UserProvider>(context, listen: false)
  //         .setSubscriptions(userPurchases);
  //   }
  // }

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
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/vault/Only Vault.svg',
                        height: 41,
                      ),
                    ),
                    SizedBoxes.vertical3Px,
                    Text(
                        'All The Resources Any Pre Medical Student Could Ever Need',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 17)),
                    SizedBoxes.vertical26Px,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GetGradientButton(
                              textPath: 'assets/images/vault/Text.svg',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TopicalGuides()));
                              }),
                          SizedBoxes.horizontal10Px,
                          GradientButton(
                            text: 'Mnemonics',
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFF043D2A),
                                Color(0xFF2DD7D3)
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MnemonicsHome()));
                            },
                          ),
                          SizedBoxes.horizontal10Px,
                          GradientButton(
                              text: 'StudyNotes',
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
                                            const StudyNotesHome()));
                              }),
                          SizedBoxes.horizontal10Px,
                          GetGradientButton(
                              textPath: 'assets/images/vault/Text (5).svg',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShortlistingsHome()));
                              }),
                        ],
                      ),
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
                                              const EstuffHomeScreen()));
                                },
                                child: Text('View All',
                                    style: PreMedTextTheme().heading1.copyWith(
                                        color:
                                            PreMedColorTheme().primaryColorRed,
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
                    const EssenceStuffBuilder(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15)
                    .copyWith(top: 26, right: 15, left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                                'assets/images/vault/tpical guides.svg'),
                            const Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TopicalGuides()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      'View All',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            PreMedColorTheme().primaryColorRed,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                            top: 30,
                            left: 10,
                            child: Text(
                              'Toppers’ Insights to every topic from every board!',
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ))
                      ],
                    ),
                    //
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: TopicalGuidesPage()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(top: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                                const StudyNotesHome()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 12, right: 5),
                                    child: Text(
                                      'View All',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: PreMedColorTheme()
                                            .primaryColorRed, //
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
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
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 7),
                child: StudyNotesPage(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 26, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Short',
                                style: PreMedTextTheme().heading1.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: PreMedColorTheme().primaryColorRed,
                                    ),
                              ),
                              TextSpan(
                                text: 'Listings',
                                style: PreMedTextTheme().heading1.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShortlistingsHome()));
                            //To Navigate
                          },
                          child: Text('View All',
                              textAlign: TextAlign.center,
                              style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().primaryColorRed,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    SizedBoxes.vertical3Px,
                    Text(
                      'One Chapter. One Page. Half-Hour Revisions!',
                      style: PreMedTextTheme().heading1.copyWith(
                          color: PreMedColorTheme().black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: ShortListingNotesPage(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(top: 26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                                'assets/images/vault/mnemonics logo.svg'),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0), // Adjust this value as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MnemonicsHome(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color:
                                            PreMedColorTheme().primaryColorRed,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 50,
                          left: 8,
                          child: Text(
                            'All the mnemonics you need. No more mindless repetition!',
                            style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),

                    // First Section
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 4),
                child: Text(
                  'All the mnemonics you need. No more mindless repetition!',
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: PreMedTextTheme().heading1.copyWith(
                      color: PreMedColorTheme().black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 20),
                child: MnemonicsReelBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetGradientButton extends StatelessWidget {
  const GetGradientButton(
      {super.key, required this.textPath, required this.onTap});
  final String textPath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 40,
          offset: Offset(0, 20),
        ),
      ]),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0.8500000238418579),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8)),
          onPressed: onTap,
          child: SvgPicture.asset(textPath)),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.gradient,
    required this.onPressed,
  });
  final String text;
  final Gradient gradient;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.8500000238418579),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return gradient.createShader(bounds);
          },
          child: Text(text,
              style: PreMedTextTheme()
                  .heading1
                  .copyWith(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({super.key, required this.text, required this.fontSize});
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[Color(0xFF44009B), Color(0xFF2370CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
