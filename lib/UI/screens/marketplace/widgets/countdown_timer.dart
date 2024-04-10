import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({super.key});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  int hours = 0;
  int minutes = 0;
  int seconds = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    final bundleProvider =
    Provider.of<BundleProvider>(context, listen: false);
    bundleProvider.fetchDiscount();

    _resetTimer();
    _startTimer();
  }

  void _resetTimer() {
    final DateTime now = DateTime.now();
    final DateTime resetTime = DateTime(now.year, now.month, now.day, 24);
    final Duration timeDifference = resetTime.difference(now);

    hours = timeDifference.inHours;
    minutes = timeDifference.inMinutes % 60;
    seconds = timeDifference.inSeconds % 60;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          if (minutes > 0) {
            minutes--;
            seconds = 59;
          } else {
            if (hours > 0) {
              hours--;
              minutes = 59;
              seconds = 59;
            } else {
              _resetTimer();
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bundleProvider =
    Provider.of<BundleProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: PreMedColorTheme().primaryGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Transform.scale(
                  scale: 1,
                  child: Image.asset(
                    'assets/images/firework.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: PreMedColorTheme().primaryGradient,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBoxes.verticalExtraGargangua,
                Text(
                  '${bundleProvider.discount} OFF',
                  style: PreMedTextTheme().heading1.copyWith(
                    color: PreMedColorTheme().white,
                    fontSize: 40,
                    height: 0.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBoxes.verticalMicro,
                Text(
                  'On all bundles',
                  style: PreMedTextTheme().heading5.copyWith(
                    color: PreMedColorTheme().white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBoxes.verticalBig,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: PreMedColorTheme().white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimerColumn('Hours', '$hours'),
                          Text(
                            ":",
                            style: PreMedTextTheme().heading1.copyWith(
                              color: PreMedColorTheme().primaryColorBlue,
                            ),
                          ),
                          _buildTimerColumn('Minutes', _formatTime(minutes)),
                          Text(
                            ":",
                            style: PreMedTextTheme().heading1.copyWith(
                              color: PreMedColorTheme().primaryColorBlue,
                            ),
                          ),
                          _buildTimerColumn('Seconds', _formatTime(seconds)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerColumn(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: PreMedTextTheme().subtext1.copyWith(
              fontSize: 25.0,
              color: PreMedColorTheme().primaryColorRed,
            )),
      ],
    );
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }
}


class CustomDraw extends CustomPainter {
  CustomDraw(Color color, this.textWidth, {this.radius = 0}) {
    painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;
  }
  late Paint painter;
  late double radius;
  late double textWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(size.width - ((size.width - textWidth) / 3), 0);

    path.lineTo(size.width - radius, 0);
    path.cubicTo(size.width - radius, 0, size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.cubicTo(size.width, size.height - radius, size.width, size.height,
        size.width - radius, size.height);

    path.lineTo(radius, size.height);
    path.cubicTo(radius, size.height, 0, size.height, 0, size.height - radius);

    path.lineTo(0, radius);
    path.cubicTo(0, radius, 0, 0, radius, 0);
    path.lineTo((size.width - textWidth) / 3, 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomTitleWidget extends StatefulWidget {
  const CustomTitleWidget(
      {super.key,
        required this.height,
        required this.width,
        required this.title,
        this.color,
        this.radius});
  final double height;
  final double width;
  final double? radius;
  final String title;
  final Color? color;

  @override
  State<CustomTitleWidget> createState() => _CustomTitleWidgetState();
}

class _CustomTitleWidgetState extends State<CustomTitleWidget> {
  GlobalKey textKey = GlobalKey();
  double textHeight = 0.0;
  double textWidth = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final textKeyContext = textKey.currentContext;
        if (textKeyContext != null) {
          final box = textKeyContext.findRenderObject()! as RenderBox;
          textHeight = box.size.height;
          textWidth = box.size.width;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        CustomPaint(
          painter: CustomDraw(
            widget.color ?? Colors.white,
            textWidth,
            radius: widget.radius ?? 0,
          ),
          child: SizedBox(
            height: widget.height,
            width: widget.width,
          ),
        ),
        Positioned(
          top: -textHeight / 2,
          child: Padding(
            key: textKey,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.title,
              style: PreMedTextTheme().headline.copyWith(
                color: PreMedColorTheme().white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
