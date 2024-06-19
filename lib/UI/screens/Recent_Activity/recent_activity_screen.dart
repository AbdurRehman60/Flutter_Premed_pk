// import 'package:flutter_svg/svg.dart';
// import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/widgets/recent_activity.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
// import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
// import 'package:provider/provider.dart';

// class RecentActivityScreen extends StatefulWidget {
//   const RecentActivityScreen({super.key});

//   @override
//   State<RecentActivityScreen> createState() => _RecentActivityScreenState();
// }

// class _RecentActivityScreenState extends State<RecentActivityScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBF0F3),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60.0),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Material(
//               elevation: 4,
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               clipBehavior: Clip.hardEdge,
//               child: SizedBox(
//                 width: 37,
//                 height: 37,
//                 child: SvgPicture.asset(
//                   'assets/icons/left-arrow.svg',
//                   width: 9.33,
//                   height: 18.67,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ChangeNotifierProvider(
//         create: (_) => RecentAttemptsProvider(),
//         child: Consumer<RecentAttemptsProvider>(
//           builder: (context, provider, child) {
//             if (provider.recentAttempts.isEmpty) {
//               provider.fetchRecentAttempts(
//                   '64c68bc9f093d0bd25c026de'); // replace with actual user ID
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Recent Activity',
//                         style: PreMedTextTheme().heading4.copyWith(
//                             fontWeight: FontWeight.w800, fontSize: 28),
//                       ),
//                       const SizedBox(
//                         height: 5.0,
//                       ),
//                       Text(
//                         'Your recent activity, on the website and the app.',
//                         style: PreMedTextTheme().body.copyWith(fontSize: 17),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: provider.recentAttempts.length,
//                       itemBuilder: (context, index) {
//                         RecentAttempt recentAttempt =
//                             provider.recentAttempts[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 15, right: 15),
//                           child: RecentActivityCard1(
//                             onTap: () {},
//                             acivityname: recentAttempt.deckName,
//                             date: recentAttempt.attemptedDate.toString(),
//                             progressValue: (recentAttempt.totalAttempts! /
//                                     recentAttempt.totalQuestions!.toDouble()) *
//                                 1,
//                             mode: recentAttempt
//                                 .mode, // replace with actual progress value
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/widgets/bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/widgets/recent_activity.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
import 'package:provider/provider.dart';

class RecentActivityScreen extends StatefulWidget {
  const RecentActivityScreen({super.key});

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 37,
                height: 37,
                child: SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 9.33,
                  height: 18.67,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => RecentAttemptsProvider(),
        child: Consumer<RecentAttemptsProvider>(
          builder: (context, provider, child) {
            if (provider.recentAttempts.isEmpty) {
              provider.fetchRecentAttempts(
                  '64c68bc9f093d0bd25c026de'); // replace with actual user ID
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Activity',
                        style: PreMedTextTheme().heading4.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 28),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Your recent activity, on the website and the app.',
                        style: PreMedTextTheme().body.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: provider.recentAttempts.length,
                      itemBuilder: (context, index) {
                        RecentAttempt recentAttempt =
                            provider.recentAttempts[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: RecentActivityCard1(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => BottomSheetWidget(
                                  progressValue: (recentAttempt.totalAttempts! /
                                          recentAttempt.totalQuestions!
                                              .toDouble()) *
                                      1,
                                  onTap: () {},
                                  acivityname: recentAttempt.deckName,
                                  date: recentAttempt.attemptedDate.toString(),
                                  mode: recentAttempt.mode,
                                ),
                              );
                            },
                            acivityname: recentAttempt.deckName,
                            date: recentAttempt.attemptedDate.toString(),
                            progressValue: (recentAttempt.totalAttempts! /
                                    recentAttempt.totalQuestions!.toDouble()) *
                                1,
                            mode: recentAttempt.mode,
                          ),
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
