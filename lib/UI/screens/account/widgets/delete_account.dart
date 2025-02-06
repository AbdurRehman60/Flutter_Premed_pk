import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_textfield.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/login.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().background,
        leading: Container(
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
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Account',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black, fontWeight: FontWeight.bold),
            ),
            SizedBoxes.vertical2Px,
            Text('SETTINGS',
                style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PreMedColorTheme().black,
                    ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBoxes.verticalBig,
            CustomTextField(
              controller: _emailController,
              prefixIcon: const Icon(Icons.mail_outline),
              labelText: 'Email address',
              hintText: 'Enter your email',
              validator: (value) => validateEmail(value),
            ),
            SizedBoxes.verticalBig,
            CustomTextField(
              controller: _passwordController,
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: "Password",
              hintText: "Enter your password",
              obscureText: true,
              validator: (value) => validatePassword(value),
            ),
            SizedBoxes.verticalBig,
            if (_isLoading)
              const CircularProgressIndicator()
            else
              CustomButton(
                onPressed: () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (email.isEmpty || password.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Email and password are required.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/delete.svg', // Use a delete icon
                            ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Delete Account', // Dialog title
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: Colors
                                      .red, // Use red to indicate a serious action
                                ),
                              ),
                            ),
                          ],
                        ),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Are you sure you want to delete your account?', // Confirmation message
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'This action cannot be undone. All your data will be permanently deleted.', // Warning message
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space buttons evenly
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E6E6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text(
                                      'Cancel', // Cancel button
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors
                                            .grey, // Use grey for a neutral action
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 10), // Add spacing between buttons
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E6E6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog

                                      try {
                                        setState(() {
                                          _isLoading =
                                              true; // Show loading indicator
                                        });
                                        final userProvider =
                                            Provider.of<UserProvider>(context,
                                                listen: false);
                                        final result =
                                            await userProvider.deleteAccount(
                                          email,
                                          password,
                                        );

                                        setState(() {
                                          _isLoading =
                                              false; // Hide loading indicator
                                        });

                                        if (result['status']) {
                                          // Account deletion successful
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text('Success'),
                                              content: const Text(
                                                  'Account deleted successfully.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close success dialog
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const LoginScreen(), // Navigate to login screen
                                                      ),
                                                      (route) => false,
                                                    );
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          // Handle deletion failure
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text('Error'),
                                              content: Text(result['message']),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close error dialog
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        setState(() {
                                          _isLoading =
                                              false; // Hide loading indicator
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('An error occurred: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Delete', // Delete button
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors
                                            .red, // Use red to indicate a destructive action
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );

                  // final userProvider =
                  //     Provider.of<UserProvider>(context, listen: false);
                  // setState(() {
                  //   _isLoading = true;
                  // });
                  // final result = await userProvider.deleteAccount(
                  //   email,
                  //   password,
                  // );
                  // setState(() {
                  //   _isLoading = false;
                  // });
                  // if (result['status']) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (_) => AlertDialog(
                  //       title: const Text('Success'),
                  //       content: const Text('Account deleted successfully'),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //             Navigator.of(context).pushAndRemoveUntil(
                  //               MaterialPageRoute(
                  //                 builder: (_) => const LoginScreen(),
                  //               ),
                  //               (route) => false,
                  //             );
                  //           },
                  //           child: const Text('OK'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (_) => AlertDialog(
                  //       title: const Text('Error'),
                  //       content: Text(result['message']),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: const Text('OK'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
                },
                buttonText: 'Delete My Account',
              ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!value.contains('@')) {
    return 'Invalid email format';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  return null;
}
