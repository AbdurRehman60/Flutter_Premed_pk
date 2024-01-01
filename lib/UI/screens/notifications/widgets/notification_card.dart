import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/web_notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});
  final WebNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      color: PreMedColorTheme().neutral200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              notification.content.iconSrc,
              width: 75,
              height: 75,
            ),
            SizedBoxes.horizontalGargangua,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notification.content.text,
                    style: PreMedTextTheme().heading6,
                  ),
                  SizedBoxes.verticalBig,
                  Text(notification.createdAt.toLocal().toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
