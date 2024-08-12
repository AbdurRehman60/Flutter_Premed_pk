import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/notifications/widgets/notification_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';

import '../../../models/web_notification_model.dart';
import '../../../providers/web_notifications_provider.dart';
import '../../Widgets/global_widgets/empty_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const PopButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Mark As Read',
              style: GoogleFonts.rubik(
                color: const Color(0xFFEC5863),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: GoogleFonts.rubik(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBoxes.verticalBig,
              Consumer<WebNotificationsProvider>(
                builder: (context, webNotificationsProvider, _) {
                  if (webNotificationsProvider.webNotificationList.isEmpty) {
                    webNotificationsProvider.fetchNotifications();
                  }
                  final bool isLoading =
                      webNotificationsProvider.notificationStatus ==
                          Status.Fetching;

                  final List<WebNotificationModel> a = webNotificationsProvider
                      .webNotificationList.reversed
                      .toList();
                  return isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : webNotificationsProvider.webNotificationList.isEmpty
                          ? EmptyState(
                              displayImage: PremedAssets.Notfoundemptystate,
                              title: "You Don't Have any notifications",
                              body: "")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: webNotificationsProvider
                                    .webNotificationList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return NotificationWidget(
                                      notification: a[index]);
                                },
                              ),
                            );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
