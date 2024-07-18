import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.uni});
  final String uni;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool _provincialMDCAT = false;
  bool _akuTest = false;
  bool _numsTest = false;
  bool _other = false;
  String? _selectedUniversity;
  String? _selectedExamType;
  DateTime? _selectedDate;
  Timer? _timer;
  final _timeLeftController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timeLeftController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedUniversity = prefs.getString('selectedUniversity');
      _selectedExamType = prefs.getString('selectedExamType');
      final dateString = prefs.getString('selectedDate');
      if (dateString != null) {
        _selectedDate = DateTime.parse(dateString);
        _startTimer(_selectedDate!);
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedUniversity != null) {
      prefs.setString('selectedUniversity', _selectedUniversity!);
    }
    if (_selectedExamType != null) {
      prefs.setString('selectedExamType', _selectedExamType!);
    }
    if (_selectedDate != null) {
      prefs.setString('selectedDate', _selectedDate!.toIso8601String());
    }
  }

  void _startTimer(DateTime date) {
    _timer?.cancel();
    _selectedDate = date;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = date.difference(now);
      final days = difference.inDays;
      final hours = difference.inHours.remainder(24);
      final minutes = difference.inMinutes.remainder(60);
      final seconds = difference.inSeconds.remainder(60);
      final timeLeft = '$days :  $hours :  $minutes :  $seconds';
      setState(() {
        _timeLeftController.text = timeLeft;
      });
    });
  }

  Future<void> showUniversitySelectionDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Your Dream Medical University'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    'Karachi Medical and Dental College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pop('Karachi Medical and Dental College');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Chandka Medical College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop('Chandka Medical College');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Dow Medical College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop('Dow Medical College');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Sindh Medical College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop('Sindh Medical College');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Khairpur Medical College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop('Khairpur Medical College');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Liaquat University of Medical and Health Sciences',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(
                        'Liaquat University of Medical and Health Sciences');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Peoples University of Medical and Health Sciences for Women',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(
                        'Peoples University of Medical and Health Sciences for Women');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Dow International Medical College',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pop('Dow International Medical College');
                  },
                ),
                // Add more ListTiles for other universities
              ],
            ),
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedUniversity = result;
      });
      _saveData();
    }
  }

  Future<void> showExamTypeSelectionDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Exam Type'),
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
                    border: Border.all(color: Colors.grey),
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
                    border: Border.all(color: Colors.grey),
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
                    border: Border.all(color: Colors.grey),
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
                width: 270,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    if (_provincialMDCAT || _akuTest || _numsTest || _other) {
                      Navigator.of(context).pop();

                      showDateDialog(context);
                    } else {
                      if (kDebugMode) {
                        print('Please select an exam');
                      }
                    }
                  },
                  child: const Text('Select'),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedExamType = result;
      });
      _saveData();
    }
  }

  Future<void> showDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _saveData();
      _startTimer(picked);
    }
  }

  Future<void> _showDialogsSequentially(BuildContext context) async {
    await showUniversitySelectionDialog(context);
    if (_selectedUniversity != null) {
      await showExamTypeSelectionDialog(context);
      if (_selectedExamType != null) {
        await showDateDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        decoration: BoxDecoration(
          color: PreMedColorTheme().white, // use the provided background color
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 400,
        height: 167,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    // ignore: unnecessary_null_comparison
                    widget.uni != null
                        ? '🎓 Time left to prepare for my dream\n university  :$_selectedUniversity'
                        : '🎓 Time left to prepare for my dream\n university  : Not selected',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeights.medium,
                          fontSize: 20,
                          color: PreMedColorTheme().red),
                      enabled: false,
                      controller: _timeLeftController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time Left',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      _showDialogsSequentially(context);
                    },
                    child: const Text('Set a Goal'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
