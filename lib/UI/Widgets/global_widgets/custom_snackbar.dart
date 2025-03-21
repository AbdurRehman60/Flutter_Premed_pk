// ignore_for_file: constant_identifier_names

import 'package:premedpk_mobile_app/constants/constants_export.dart';

enum SnackbarType { INFO, SUCCESS }

void showSnackbar(BuildContext context, String message, SnackbarType type,
    {bool? navigate}) {
  final bool shouldNavigate = navigate ?? false;

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
