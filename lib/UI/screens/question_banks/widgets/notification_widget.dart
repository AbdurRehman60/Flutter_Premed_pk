import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/assets.dart';
import '../../notifications/notification_page.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({super.key});

  @override
  State<NotificationIconWidget> createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  bool newNotification = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          newNotification = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotificationPage(),
          ),
        );
      },
      child: SizedBox(
        width: 28,
        height: 35,
        child: SvgPicture.asset(newNotification
            ?  PremedAssets.BellIconWithNotification
            : PremedAssets.BellIcon),
      ),
    );
  }
}
