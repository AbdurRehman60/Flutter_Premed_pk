
import 'package:premedpk_mobile_app/UI/screens/notifications/widgets/notification_card.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/empty_state.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/web_notification_model.dart';
import 'package:premedpk_mobile_app/providers/web_notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar( centerTitle: false,
          backgroundColor: PreMedColorTheme().white,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: PreMedColorTheme().primaryColorRed),
                onPressed: () {Navigator.of(context).pop();}
            ),
          ),
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBoxes.horizontalMedium,
            ],

          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(onPressed: (){}, child: Text(
                'Marks As Read',
                style: PreMedTextTheme().body.copyWith(color: PreMedColorTheme().primaryColorRed, fontSize: 16, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Notifications',
                      style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<WebNotificationsProvider>(
              builder: (context, webNotificationsProvider, _) {
                if (webNotificationsProvider.webNotificationList.isEmpty) {
                  webNotificationsProvider.fetchNotifications();
                }
                final bool isLoading =
                    webNotificationsProvider.notificationStatus == Status.Fetching;

                final List<WebNotificationModel> a =
                webNotificationsProvider.webNotificationList.reversed.toList();
                return isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : webNotificationsProvider.webNotificationList.isEmpty
                    ? EmptyState(
                    displayImage: PremedAssets.Notfoundemptystate,
                    title: "You Don't Have any notifications",
                    body: "")
                    : ListView.builder(
                  itemCount:
                  webNotificationsProvider.webNotificationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: NotificationCard(
                            notification: a[index],
                          ),
                        ),
                        if (index < webNotificationsProvider.webNotificationList.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(
                              height: 0.5,
                              color: Colors.grey, // Adjust color as needed
                            ),
                          ),
                      ],

                    );

                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
