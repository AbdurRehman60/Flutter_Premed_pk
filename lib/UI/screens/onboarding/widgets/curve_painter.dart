import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Color of the curved shape
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height * 0.75) // Start at the bottom-left corner
      ..quadraticBezierTo(size.width * 0.5, size.height, size.width,
          size.height * 0.75) // Create a curve
      ..lineTo(size.width, 0) // Finish at the top-right corner
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
