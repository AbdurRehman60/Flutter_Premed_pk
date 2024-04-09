import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/widgets/or_divider.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/web_notification_model.dart';
import 'package:premedpk_mobile_app/utils/HumanReadableTime.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});
  final WebNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.network(
            notification.content.iconSrc,
            width: 44,
            height: 44,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Image.network(
                "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/CustomImages/PreMedCircleLogo.cffae65f.png",
                width: 44,
                height: 44,
              );
            },
          ),
          SizedBoxes.horizontalGargangua,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notification.content.text,
                  style: PreMedTextTheme().heading7.copyWith(height: 1.5),
                  maxLines: 4,
                ),
                SizedBoxes.verticalMedium,
              ],
            ),
          ),
          SizedBoxes.horizontalMedium,
          Text(getTimeDifference(notification.createdAt))
        ],
      ),
    );
  }
}
