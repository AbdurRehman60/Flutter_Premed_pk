import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/pre_eng/screens/pre_eng_vault_home.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/vault_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/screens/Dashboard_Screen/dashboard_screen.dart';
import '../../pre_engineering/UI/screens/dashboard/dashboard_home.dart';

class PreMedProvider with ChangeNotifier {

  PreMedProvider() {
    loadFromPreferences();
  }
  static const _isPreMedKey = 'isPreMed';
  bool _isPreMed = true;

  bool get isPreMed => _isPreMed;

  Future<void> loadFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPreMed =  prefs.getBool(_isPreMedKey) ?? true;
    notifyListeners();
  }

  Future<void> setPreMed(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPreMed = value;
    await prefs.setBool(_isPreMedKey, _isPreMed);
    notifyListeners();
  }
}





class DashboardSwitcher extends StatelessWidget {
  const DashboardSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreMedProvider>(
      builder: (context, preMedProvider, child) {
        if (preMedProvider.isPreMed) {
          return const DashboardScreen();
        } else {
          return const EngineeringDashboardScreen();
        }
      },
    );
  }
}


class VaultSwitcher extends StatelessWidget {
  const VaultSwitcher({super.key});

  @override
  Widget build(BuildContext context) {  return Consumer<PreMedProvider>(
    builder: (context, preMedProvider, child) {
      if (preMedProvider.isPreMed) {
        return const VaultHome();
      } else {
        return const PreEngVaultHome();
      }
    },
  );
  }
}
