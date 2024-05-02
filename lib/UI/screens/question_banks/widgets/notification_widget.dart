import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/assets.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({super.key});

  @override
  State<NotificationIconWidget> createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  bool newNotification = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          newNotification = true;
        });
      },
      child: SizedBox(
        width: 28,
        height: 35,
        child: SvgPicture.asset(newNotification
            ? PremedAssets.BellIconWithNotification
            : PremedAssets.BellIcon),
      ),
    );
  }
}
