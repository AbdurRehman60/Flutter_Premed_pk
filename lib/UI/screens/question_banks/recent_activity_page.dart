import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/recent_activity_widget.dart';
import 'package:premedpk_mobile_app/models/recent_activity_model.dart';
import 'package:premedpk_mobile_app/providers/recent_activity_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/sized_boxes.dart';

class RecentActivityPage extends StatelessWidget {
  const RecentActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recentActivityPro =
        Provider.of<RecentActivityProvider>(context, listen: false);
    late List<RecentActivityModel> recentActivityList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.rubik(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              Text(
                'Your recent activity, on the website and the app.',
                style: GoogleFonts.rubik(
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                    height: 1.3),
              ),
              SizedBoxes.verticalBig,
              FutureBuilder(
                  future: recentActivityPro.fetchRecentActivity(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle errors
                      return const Center(
                        child: Text('Error fetching data'),
                      );
                    } else {
                      recentActivityList = recentActivityPro.recentActivityList;
                      if (recentActivityList.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: recentActivityList.length,
                              itemBuilder: (context, index) {
                                return RecentActivityWidget(
                                  topPadding: const EdgeInsets.only(top: 20),
                                  recent: recentActivityList[index],
                                  line: Column(
                                    children: [
                                      SizedBoxes.verticalBig,
                                      const Divider(
                                        thickness: 1,
                                        color: Color(0x82000000),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text('No recent activity'),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
