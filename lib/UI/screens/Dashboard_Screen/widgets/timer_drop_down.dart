import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/sheet_test.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';

import 'datecard.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.timeLeft, required this.uni});
  final String? timeLeft;
  final String? uni;

  @override
  // ignore: library_private_types_in_public_api
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? _selectedValue;
  String? _tempSelectedValue;
  final _timeLeftController = TextEditingController();

  bool _provincialMDCAT = false;
  bool _akuTest = false;
  bool _numsTest = false;
  bool _other = false;

  @override
  void initState() {
    super.initState();
    if (widget.timeLeft != null) {
      _timeLeftController.text = widget.timeLeft!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.uni != null
                ? '🎓 Time left to prepare for my dream university : ${widget.uni}'
                : '🎓 Time left to prepare for my dream university :     Not selected',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _timeLeftController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Time Left',
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PreMedColorTheme().red,
                ),
                onPressed: () {
                  _showAlertDialog(context);
                },
                child: const Text(
                  'Set a Goal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    _tempSelectedValue = _selectedValue;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Your Dream Medical \nUniversity',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 900,
                height: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _tempSelectedValue ?? 'No university selected',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                'Karachi Medical and Dental College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Karachi Medical and Dental College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Chandka Medical College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Chandka Medical College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Dow Medical College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue = 'Dow Medical College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Sindh Medical College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue = 'Sindh Medical College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Khairpur Medical College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Khairpur Medical College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Liaquat University of Medical and Health Sciences',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Liaquat University of Medical and Health Sciences';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Peoples University of Medical and Health Sciences for Women',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Peoples University of Medical and Health Sciences for Women';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                            ListTile(
                              title: const Text(
                                'Dow International Medical College',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                setState(() {
                                  _tempSelectedValue =
                                      'Dow International Medical College';
                                  _selectedValue = _tempSelectedValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Center(
                  child: SizedBox(
                    width: 270,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PreMedColorTheme().red,
                      ),
                      onPressed: _selectedValue != null
                          ? () {
                              _show2ndAlertDialog(context);
                            }
                          : null,
                      child: const Text(
                        'SELECT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _show2ndAlertDialog(BuildContext context) {
    return  AlertDialog(
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
                foregroundColor: PreMedColorTheme().white,
                backgroundColor: PreMedColorTheme().red,
              ),
              onPressed: () {
                if (_provincialMDCAT || _akuTest || _numsTest || _other) {
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return DateDialog(
                        uni: _selectedValue!,
                      );
                    },
                  );
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
  }
}


