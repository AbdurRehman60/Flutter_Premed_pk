import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/datecard.dart';

class ExamSelectionDialog extends StatefulWidget {
  const ExamSelectionDialog({super.key, this.university});
  final String? university;

  @override
  // ignore: library_private_types_in_public_api
  _ExamSelectionDialogState createState() => _ExamSelectionDialogState();
}

class _ExamSelectionDialogState extends State<ExamSelectionDialog> {
  bool _provincialMDCAT = false;
  bool _akuTest = false;
  bool _numsTest = false;
  bool _other = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select The Exams You are \n Appearing for',
                style: TextStyle(fontSize: 14),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  if (_provincialMDCAT)
                    const Icon(Icons.check, color: Colors.blue, size: 18)
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 10),
                  const Text('Provincial MDCAT'),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _provincialMDCAT = !_provincialMDCAT;
              });
            },
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  if (_akuTest)
                    const Icon(Icons.check, color: Colors.blue, size: 18)
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 10),
                  const Text('AKU Test'),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _akuTest = !_akuTest;
              });
            },
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  if (_numsTest)
                    const Icon(Icons.check, color: Colors.blue, size: 18)
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 10),
                  const Text('NUMS Test'),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _numsTest = !_numsTest;
              });
            },
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  if (_other)
                    const Icon(Icons.check, color: Colors.blue, size: 18)
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 10),
                  const Text('Other'),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _other = !_other;
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 270, // Set the width of the button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Set the text color to white
              ),
              onPressed: () {
                if (_provincialMDCAT || _akuTest || _numsTest || _other) {
                  // Close the dialog
                  Navigator.of(context).pop();
                  // Show the DateDialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DateDialog(
                        uni: widget.university!,
                      );
                    },
                  );
                } else {
                  // Display an error message
                  if (kDebugMode) {
                    print('Please select an exam');
                  } // Removed SnackBar
                }
              },
              child: const Text('Select'),
            ),
          ),
        ],
      ),
    );
  }
}
