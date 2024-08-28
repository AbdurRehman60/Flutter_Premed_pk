import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/edit_profile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/subscriptions_details.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/vaultProviders/premed_provider.dart';

class AccountBeforeEdit extends StatefulWidget {
  const AccountBeforeEdit({super.key});

  @override
  State<AccountBeforeEdit> createState() => _AccountBeforeEditState();
}

class _AccountBeforeEditState extends State<AccountBeforeEdit> {
  @override
  Widget build(BuildContext context) {
    final preMedProvider = Provider.of<PreMedProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
            leading: const PopButton(),
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Account',
                    style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBoxes.vertical2Px,
                  Text('Overview',
                      style: PreMedTextTheme().subtext.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: PreMedColorTheme().black,
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
              vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '@',
                                style: PreMedTextTheme().body1.copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                                    ),
                              ),
                              TextSpan(
                                text: userProvider.user!.fullName,
                                style: PreMedTextTheme().body1.copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: PreMedColorTheme().black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBoxes.vertical2Px,
                        Text(
                          userProvider.user!.userName,
                          style: PreMedTextTheme().body1.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: PreMedColorTheme().blue),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()));
                    },
                    child: Text(
                      'EDIT',
                      style: PreMedTextTheme().body1.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBoxes.vertical15Px,
              const BundleCard(),
              SizedBoxes.vertical25Px,
              Text(
                'Dashboard Settings',
                style: PreMedTextTheme().body1.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
              ),
              SizedBoxes.vertical22Px,
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                          vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8500000238418579),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(12),
                          value: 'Entrance Exam',
                          isExpanded: true,
                          icon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                MediaQuery.of(context).size.width * 0.01),
                            child: Image.asset(
                              Provider.of<PreMedProvider>(context)
                                  .isPreMed ? PremedAssets.ArrowDownRed : PremedAssets.arrowDownBlue,
                              width: 15,
                              height: 15,
                            ),
                          ),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              // Update selectedValue
                              setState(() {
                                // selectedValue = newValue;
                              });
                            }
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return <String>['Entrance Exam']
                                .map<Widget>((String value) {
                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/icons/premed log.png',
                                    width: 30,
                                  ),
                                  Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          items: <String>['Entrance Exam']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: PreMedTextTheme().body1.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBoxes.horizontal10Px,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                            vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8500000238418579),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(12),
                            isExpanded: true,
                            value: preMedProvider.isPreMed
                                ? 'Pre-Medical'
                                : 'Pre-Engineering',
                            icon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Image.asset(
                                Provider.of<PreMedProvider>(context)
                                    .isPreMed ? PremedAssets.ArrowDownRed : PremedAssets.arrowDownBlue,
                                width: 15,
                                height: 15,
                              ),
                            ),
                            underline: const SizedBox(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                preMedProvider
                                    .setPreMed(newValue == 'Pre-Medical');
                              }
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return <String>['Pre-Medical', 'Pre-Engineering']
                                  .map<Widget>((String value) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/icons/premed log.png',
                                      width: 30,
                                    ),
                                    Text(
                                      value,
                                      style: PreMedTextTheme().body1.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                );
                              }).toList();
                            },
                            items: <String>['Pre-Medical', 'Pre-Engineering']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: PreMedTextTheme().body1.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                     // Space between the dropdowns
                  ],
                ),
              ),
              SizedBoxes.vertical25Px,
              Text(
                'Contact Information',
                style: PreMedTextTheme().body1.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
              ),
              SizedBoxes.verticalGargangua,
              Text(
                'Your Phone Number',
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().black.withOpacity(0.5),
                      fontSize: 10,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
              ),
              SizedBoxes.verticalBig,
              Text(
                userProvider.user!.phoneNumber,
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().blue,
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
              ),
              SizedBoxes.vertical26Px,
              Text(
                'Educational Information',
                style: PreMedTextTheme().body1.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.12,
                    ),
              ),
              SizedBoxes.verticalGargangua,
              Text(
                'City',
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().black.withOpacity(0.5),
                      fontSize: 10,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
              ),
              SizedBoxes.verticalBig,
              Text(
                userProvider.user!.city,
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().blue,
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
              ),
              SizedBoxes.verticalGargangua,
              Text(
                'University/College',
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().black.withOpacity(0.5),
                      fontSize: 10,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
              ),
              SizedBoxes.verticalBig,
              Text(
                userProvider.user?.info.institution ??  'N/A',
                style: PreMedTextTheme().body1.copyWith(
                      color: PreMedColorTheme().blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 0.09,
                    ),
              ),
              // SizedBoxes.verticalGargangua,
              // Text(
              //   "Parent's Information",
              //   style: PreMedTextTheme().body1.copyWith(
              //         color: Colors.black,
              //         fontSize: 12,
              //         fontFamily: 'Rubik',
              //         fontWeight: FontWeight.w700,
              //         height: 0.12,
              //       ),
              // ),
              // SizedBoxes.verticalGargangua,
              // Text(
              //   "Parent's Name",
              //   style: PreMedTextTheme().body1.copyWith(
              //         color: PreMedColorTheme().black.withOpacity(0.5),
              //         fontSize: 10,
              //         fontFamily: 'Rubik',
              //         fontWeight: FontWeight.w700,
              //         height: 0.09,
              //       ),
              // ),
              // SizedBoxes.verticalBig,
              // Text(
              //   userProvider.user?.parentFullName ?? 'N/A',
              //   style: PreMedTextTheme().body1.copyWith(
              //         color: PreMedColorTheme().blue,
              //         fontSize: 15,
              //         fontFamily: 'Rubik',
              //         fontWeight: FontWeight.w500,
              //         height: 0.09,
              //       ),
              // ),
              // SizedBoxes.verticalGargangua,
              // Text(
              //   "Parent's Phone Number",
              //   style: PreMedTextTheme().body1.copyWith(
              //         color: PreMedColorTheme().black.withOpacity(0.5),
              //         fontSize: 10,
              //         fontFamily: 'Rubik',
              //         fontWeight: FontWeight.w700,
              //         height: 0.09,
              //       ),
              // ),
              // SizedBoxes.verticalBig,
              // Text(
              //   userProvider.user?.parentContactNumber ?? 'N/A',
              //   style: PreMedTextTheme().body1.copyWith(
              //         color: PreMedColorTheme().blue,
              //         fontSize: 15,
              //         fontFamily: 'Rubik',
              //         fontWeight: FontWeight.w500,
              //         height: 0.09,
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BundleCard extends StatefulWidget {
  const BundleCard({super.key});

  @override
  State<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends State<BundleCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkSubscription());
  }

  void checkSubscription() {
    final userPurchases =
        Provider.of<UserProvider>(context, listen: false).user?.access;
    if (userPurchases != null) {
      Provider.of<UserProvider>(context, listen: false)
          .setSubscriptions(userPurchases);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.subscriptions.isEmpty) {
          return Container(
            height: 106,
            padding: const EdgeInsets.all(15),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.white.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                )
              ],
            ),
            child: const Center(
              child: Text(
                'No active subscriptions',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        }

        final remainingDays = _calculateRemainingDays(
            userProvider.subscriptions[0].subscriptionEndDate);

        return Container(
          height: 106,
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.85),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: Colors.white.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 40,
                offset: Offset(0, 20),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    )
                  ],
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userProvider.subscriptions[0].planName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w800,
                          height: 0.10,
                        ),
                      ),
                      const Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'ENDS IN',
                                style: PreMedTextTheme().body1.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  height: 0.13,
                                )),
                            TextSpan(
                              text: ' $remainingDays DAYS',
                              style: PreMedTextTheme().body1.copyWith(
                                color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                                fontSize: 10,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600,
                                height: 0.13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical15Px,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionDetailsScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View Details',
                        style: PreMedTextTheme().body1.copyWith(
                          color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                          fontSize: 13,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          height: 0.10,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        size: 16,
                        Icons.arrow_forward_ios_outlined,
                        color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _calculateRemainingDays(DateTime endDate) {
    final now = DateTime.now();
    return endDate.difference(now).inDays;
  }
}

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Entrance Exam',
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SvgPicture.asset(
                          'assets/images/vault/Vector.svg',
                          width: 13,
                          height: 13,
                        ),
                      ),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Update selectedValue
                          // setState(() {
                          //   selectedValue = newValue;
                          // });
                        }
                      },
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Entrance Exam']
                            .map<Widget>((String value) {
                          return Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/icons/premed log.png'),
                                const SizedBox(width: 8.0),
                                Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList();
                      },
                      items: <String>['Entrance Exam']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Space between the dropdowns
              SizedBox(
                  width: constraints.maxWidth *
                      0.05), // Adjust the space based on screen width
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: true ? 'Pre-Medical' : 'Pre-Engineering',
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SvgPicture.asset(
                          'assets/images/vault/Vector.svg',
                          width: 13,
                          height: 13,
                        ),
                      ),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // Update selectedField and provider state
                          // preMedProvider.setPreMed(newValue == 'Pre-Medical');
                          // Optionally update local state here if needed
                        }
                      },
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Pre-Medical', 'Pre-Engineering']
                            .map<Widget>((String value) {
                          return Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/icons/premed log.png'),
                                const SizedBox(width: 8.0),
                                Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList();
                      },
                      items: <String>['Pre-Medical', 'Pre-Engineering']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
