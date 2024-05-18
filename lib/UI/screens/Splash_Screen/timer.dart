import 'package:premedpk_mobile_app/constants/constants_export.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
    _startTimer();
  }

  void _resetTimer() {
    final DateTime now = DateTime.now();
    final DateTime resetTime = DateTime(now.year, now.month, now.day + 7, 24);
    final Duration timeDifference = resetTime.difference(now);

    days = timeDifference.inDays;
    hours = timeDifference.inHours % 24;
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
              if (days > 0) {
                days--;
                hours = 23;
                minutes = 59;
                seconds = 59;
              } else {
                _resetTimer();
              }
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
    return Container(
      width: 320,
      height: 70,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimerColumn('Days', '0$days'),
                  Text(
                    ":",
                    style: PreMedTextThemeRubik().heading1.copyWith(
                          color: Colors.blueAccent,
                          fontSize: 55,
                        ),
                  ),
                  _buildTimerColumn('Hours', '$hours'),
                  Text(
                    ":",
                    style: PreMedTextThemeRubik().heading1.copyWith(
                          color: Colors.blueAccent,
                          fontSize: 55,
                        ),
                  ),
                  _buildTimerColumn('Minutes', _formatTime(minutes)),
                  Text(
                    ":",
                    style: PreMedTextThemeRubik().heading1.copyWith(
                          color: Colors.blueAccent,
                          fontSize: 55,
                        ),
                  ),
                  _buildTimerColumn('Seconds', _formatTime(seconds)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerColumn(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value,
            style: PreMedTextThemeRubik().subtext1.copyWith(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: PreMedColorTheme().primaryColorRed,
                )),
        SizedBoxes.vertical2Px,
        Text(label,
            style: PreMedTextThemeRubik()
                .headline
                .copyWith(fontSize: 16, color: PreMedColorTheme().black)),
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
  double textHeight = 4.0;
  double textWidth = 4.0;

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
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              widget.title,
              style: PreMedTextTheme().headline.copyWith(
                  color: PreMedColorTheme().white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
