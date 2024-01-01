import 'package:premedpk_mobile_app/UI/screens/notifications/widgets/notification_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/web_notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WebNotificationModel a = WebNotificationModel(
      id: "64c7be20bebc87dd42bf1bf2",
      userName: "salisbinsalman0@gmail.com",
      group: "All",
      type: "Flash Sale",
      content: Content(
        iconSrc:
            "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/CustomImages/flash-sale.png",
        text: "⏳ Only 3 Days Left - Grab 75% OFF Now! Sale Ends Soon! ⏳",
        actionButton1Text: "Act Fast",
        actionButton1URL: "/pricing",
      ),
      createdAt: DateTime.parse("2023-07-31T13:34:06.419Z"),
      updatedAt: DateTime.parse("2023-07-31T13:34:06.419Z"),
      v: 0,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
        ),
        body: NotificationCard(notification: a)

        // ListView.builder(
        //   itemCount: 1,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Padding(
        //         padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        //         child: NotificationCard(notification: a),);
        //   },
        // ),
        );
  }
}
