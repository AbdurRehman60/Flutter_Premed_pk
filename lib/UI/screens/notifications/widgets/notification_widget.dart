import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/sized_boxes.dart';
import '../../../../models/web_notification_model.dart';
import '../../../../utils/HumanReadableTime.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notification});
  final WebNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              notification.content.iconSrc,
              width: 30,
              height: 30,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.network(
                  "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/CustomImages/PreMedCircleLogo.cffae65f.png",
                  width: 30,
                  height: 30,
                );
              },
            ),
            SizedBoxes.horizontal15Px,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.type,
                    style: GoogleFonts.rubik(
                      color: const Color(0xFF000000),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    notification.content.text,
                    style: GoogleFonts.rubik(
                      color: const Color(0xFF000000),
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxes.horizontal15Px,
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 37,
                      height: 14,
                      child: SvgPicture.asset('assets/icons/view.svg'),
                    ),
                    SizedBoxes.verticalMicro,
                    Text(
                      getTimeDifference(notification.createdAt),
                      style: GoogleFonts.rubik(
                        color: const Color(0xFF6E7191),
                        fontSize: 9,
                        fontWeight: FontWeight.normal,
                        height: 1.3,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBoxes.verticalBig,
        const Divider(
          thickness: 1,
          color: Color(0x82000000),
        ),
        SizedBoxes.verticalBig,
      ],
    );
  }
}
