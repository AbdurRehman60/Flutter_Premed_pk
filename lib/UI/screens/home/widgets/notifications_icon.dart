import 'package:premedpk_mobile_app/UI/screens/notifications/notifications.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/web_notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotificationsScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              PremedAssets.NotificationIcon,
              width: 30,
              height: 31,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Consumer<WebNotificationsProvider>(
              builder: (context, webNotificationsProvider, child) {
                final int itemCount =
                    webNotificationsProvider.webNotificationList.length;
                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(itemCount > 0 ? itemCount.toString() : '0',
                      style: PreMedTextTheme().subtext1.copyWith(
                            fontSize: 10,
                            color: PreMedColorTheme().white,
                          )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
