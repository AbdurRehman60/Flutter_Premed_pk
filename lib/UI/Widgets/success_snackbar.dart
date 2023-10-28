import 'package:premedpk_mobile_app/export.dart';

enum SnackbarType { INFO, SUCCESS }

void showSnackbar(BuildContext context, String message, SnackbarType type,
    {bool? navigate}) {
  bool shouldNavigate = navigate ?? false;

  if (shouldNavigate && Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      // Adjust the duration as needed
    ),
  );
}
