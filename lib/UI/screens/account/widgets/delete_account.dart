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
              prefixIcon: const  Icon(Icons.lock_outline),
              labelText: "Password",
              hintText: "Enter your password",
              obscureText: true,
              validator: (value) => validatePassword(value),
            ),
            SizedBoxes.verticalBig,
            if (_isLoading) const CircularProgressIndicator() else CustomButton(
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
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      setState(() {
                        _isLoading = true;
                      });
                      final result = await userProvider.deleteAccount(
                        email,
                        password,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      if (result['status']) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Account deleted successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
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
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(result['message']),
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
                      }
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
