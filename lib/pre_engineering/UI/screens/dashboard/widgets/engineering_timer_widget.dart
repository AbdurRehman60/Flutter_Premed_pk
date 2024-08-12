import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EnggTimer extends StatefulWidget {
  const EnggTimer({super.key});

  @override
  State<EnggTimer> createState() => _EnggTimerState();
}

class _EnggTimerState extends State<EnggTimer> {
  bool _provincialMDCAT = false;
  bool _akuTest = false;
  bool _numsTest = false;
  bool _other = false;
  String _selectedUniversity = 'Not Selected';
  String? _selectedExamType;
  DateTime? _selectedDate;
  Timer? _timer;
  String _timeLeft = '';

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedUniversity = prefs.getString('selectedUniversity')!;
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
    prefs.setString('selectedUniversity', _selectedUniversity);
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
      if (difference.isNegative || difference.inSeconds <= 0) {
        setState(() {
          _timeLeft = '00:00:00:00';
        });
        timer.cancel();
      } else {
        final days = difference.inDays;
        final hours = difference.inHours.remainder(24);
        final minutes = difference.inMinutes.remainder(60);
        final seconds = difference.inSeconds.remainder(60);
        setState(() {
          _timeLeft = '$days : $hours : $minutes : $seconds';
        });
      }
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
                        'Peoples University of Medical and Health Sciences\nfor Women');
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
      showExamTypeSelectionDialog(context);
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
                    backgroundColor: PreMedColorTheme().blue,
                  ),
                  onPressed: () {
                    if (_provincialMDCAT) {
                      Navigator.of(context).pop('Provincial MDCAT');
                    } else if (_akuTest) {
                      Navigator.of(context).pop('AKU Test');
                    } else if (_numsTest) {
                      Navigator.of(context).pop('NUMS Test');
                    } else if (_other) {
                      Navigator.of(context).pop('Other');
                    }
                  },
                  child: const Text('Save'),
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
      showDateSelectionDialog(context);
    }
  }

  Future<void> showDateSelectionDialog(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:  ColorScheme.light(
              primary: PreMedColorTheme().coolBlue,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _startTimer(selectedDate);
      });
      _saveData();
    }
  }

  Widget buildColon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            color: Colors.black54,
          ),
          const SizedBox(height: 4),
          Container(
            width: 8,
            height: 8,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> timeParts =
    _timeLeft.isNotEmpty ? _timeLeft.split(':') : [];
    return Center(
      child: Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 180, 180, 180).withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 7, left: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    PremedAssets.Badge,
                    height: 20,
                    width: 15,
                  ),
                  SizedBoxes.horizontalMicro,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TIME TO PREPARE FOR DREAM UNIVERSITY',
                        style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 12.8,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        _selectedUniversity,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w700,
                          color: PreMedColorTheme().blue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBoxes.verticalTiny,
              if (_selectedDate != null && timeParts.length == 4)
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      )
                    ],
                  ),
                  height: 72,
                  width: 312,
                  child: Card(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeParts[0],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue,
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[1],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[2],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[3],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 72,
                  width: 312,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      )
                    ],
                  ),
                  child: Card(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                           Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                           Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                           Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBoxes.verticalTiny,
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    )
                  ],
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PreMedColorTheme().blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      )
                  ),
                  onPressed: () async {
                    await showUniversitySelectionDialog(context);
                  },
                  child: const Text(
                    'Set/Change Goal',
                    style: TextStyle(fontSize: 16,fontFamily: 'Rubik'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
