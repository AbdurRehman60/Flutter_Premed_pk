import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/sheet_test.dart';

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

  @override
  void initState() {
    super.initState();
    _timeLeftController.text = widget.timeLeft!; // Set the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.uni != null
                  ? '🎓 Time left to prepare for my dream university  ${widget.uni}'
                  : '🎓 Time left to prepare for my dream university      Not selected',
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
                        borderSide:
                            BorderSide(color: Colors.grey), // border color
                      ),
                      labelText: 'Time Left',
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // background color
                  ),
                  onPressed: () {
                    _showAlertDialog(context);
                  },
                  child: const Text(
                    'Set a Goal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // text color
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
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
                width: 900, // Set the width
                height: 400, // Set the height
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5), // Add a border
                        borderRadius:
                            BorderRadius.circular(10), // Add a border radius
                      ),
                      padding: const EdgeInsets.all(10), // Add some padding
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
                            // Add other ListTile options for universities
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
                    width: 270, // Set the width of the button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set the background color to red
                      ),
                      onPressed: _selectedValue != null
                          ? () {
                              Navigator.of(context)
                                  .pop(); // Close the AlertDialog
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExamSelectionDialog(
                                  university: _selectedValue,
                                ),
                              ));
                              if (kDebugMode) {
                                print('select : iun : $_selectedValue');
                              }
                            }
                          : null,
                      child: const Text(
                        'SELECT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15, // Set the text color to white
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
}
