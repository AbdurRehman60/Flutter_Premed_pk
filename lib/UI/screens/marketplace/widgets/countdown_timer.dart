import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../constants/constants_export.dart';

class CountdownTimerWidget extends StatefulWidget {
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
    _resetTimer();
    _startTimer();
  }

  void _resetTimer() {
    DateTime now = DateTime.now();
    DateTime resetTime = DateTime(now.year, now.month, now.day, 12, 0, 0);
    Duration timeDifference = resetTime.difference(now);

    hours = timeDifference.inHours;
    minutes = (timeDifference.inMinutes % 60);
    seconds = (timeDifference.inSeconds % 60);
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
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: PreMedColorTheme().primaryGradient,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('50% OFF',
              style: PreMedTextTheme().heading1.copyWith(
                    color: PreMedColorTheme().white,
                    fontSize: 38.34,
                  )),
          SizedBoxes.verticalMicro,
          Text('On all bundles',
              style: PreMedTextTheme().heading5.copyWith(
                    color: PreMedColorTheme().white,
                    fontWeight: FontWeight.w400,
                  )),
          SizedBoxes.verticalMedium,
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimerColumn('Hours', ' $hours  :'),
                    _buildTimerColumn(
                        'Minutes', '   ${_formatTime(minutes)}  :'),
                    _buildTimerColumn('Seconds', ' ${_formatTime(seconds)}'),
                  ],
                ),
              ),
              Positioned(
                left: 50,
                top: -3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: PreMedColorTheme().primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'This offer will expire in',
                    style: PreMedTextTheme().headline.copyWith(
                          color: PreMedColorTheme().white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerColumn(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: PreMedTextTheme().heading1.copyWith(
                  color: PreMedColorTheme().white,
                )),
        const SizedBox(height: 5),
        Text(label,
            style: PreMedTextTheme().headline.copyWith(
                  color: PreMedColorTheme().white,
                )),
      ],
    );
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }
}
