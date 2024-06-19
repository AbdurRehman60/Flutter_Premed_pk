import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PremedBottomNav extends StatelessWidget {
  const PremedBottomNav(
      {super.key,
      required this.currentIndex,
      required this.onTapHome,
      required this.onTapMarketplace,
      required this.onTapQbank,
      required this.ontapVault,
      required this.onTapProfile});

  final int currentIndex;
  final VoidCallback onTapHome;
  final VoidCallback onTapMarketplace;
  final VoidCallback onTapQbank;
  final VoidCallback ontapVault;
  final VoidCallback onTapProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 100 : 70,
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavBarItem(
            icon: 'assets/images/Dashboard.png',
            width: 24,
            height: 24,
            isSelected: 0 == currentIndex,
            label: 'Dashboard',
            onTap: onTapHome,
          ),
          _BottomNavBarItem(
            icon: 'assets/images/Question Bank.png',
            width: 24,
            height: 24,
            isSelected: 1 == currentIndex,
            label: 'Qbank',
            onTap: onTapQbank,
          ),
          _MainBottomNavBarItem(
            icon: 'assets/images/Vault.png',
            isSelected: 2 == currentIndex,
            label: 'The Resource Vault',
            onTap: ontapVault,
          ),
          _BottomNavBarItem(
            icon: 'assets/images/Shop.png',
            width: 24,
            height: 24,
            isSelected: 3 == currentIndex,
            label: 'Shop',
            onTap: onTapMarketplace,
          ),
          _BottomNavBarItem(
            icon: 'assets/images/Settings.png',
            width: 24,
            height: 24,
            isSelected: 4 == currentIndex,
            label: 'Settings',
            onTap: onTapProfile,
          ),
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.label,
    required this.width,
    required this.height,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: PreMedColorTheme().white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: width,
                height: height,
                color: isSelected
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().neutral300,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: PreMedTextTheme().small,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainBottomNavBarItem extends StatelessWidget {
  const _MainBottomNavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 93,
                height: 40,
                color: isSelected
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().neutral300,
              ),
              Text(
                label,
                style: PreMedTextTheme().small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
