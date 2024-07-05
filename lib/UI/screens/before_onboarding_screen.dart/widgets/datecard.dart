import 'dart:async';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/deshboard_before_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/timer_drop_down.dart';

class DateDialog extends StatefulWidget {
  DateDialog({super.key, required this.uni});
  final String uni;

  @override
  // ignore: library_private_types_in_public_api
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  String _timeLeft = '';
  Timer? _timer;

  String _getTimeLeft(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);

    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_selectedDate != null) {
        setState(() {
          _timeLeft = _getTimeLeft(_selectedDate!);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select The Date For  Your \n Nearest Exam',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        ],
      ),
      content: SizedBox(
        width: 300, // Adjust the width
        height: 275, // Adjust the height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Enter Date',
                      suffix: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                              _dateController.text =
                                  '${picked.day}-${picked.month}-${picked.year}';
                            });
                            _startTimer();
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text('Please select the date of your nearest exam'),
            const SizedBox(height: 20),
            if (_selectedDate != null)
              Text(
                'Time left: $_timeLeft',
                style: const TextStyle(fontSize: 18),
              )
            else
              Container(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (_selectedDate != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BeforeLoginScreen(
                              uni: widget.uni,
                              timeLeft: _timeLeft); // Pass the time left value
                        },
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
