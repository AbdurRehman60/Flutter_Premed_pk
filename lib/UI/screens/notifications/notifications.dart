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
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Consumer<WebNotificationsProvider>(
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
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: NotificationCard(
                            notification: a[index],
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
