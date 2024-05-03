import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PremedBottomNav extends StatelessWidget {
  const PremedBottomNav(
      {super.key,
      required this.currentIndex,
      required this.onTapHome,
      required this.onTapMarketplace,
      //required this.onTapQbank,
      required this.onTapExpertSolution,
      required this.onTapProfile});

  final int currentIndex;
  final VoidCallback onTapHome;
  final VoidCallback onTapMarketplace;
  //final VoidCallback onTapQbank;
  final VoidCallback onTapExpertSolution;
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
            isSelected: 0 == currentIndex,
            label: 'Dashboard',
            onTap: onTapHome,
          ),
          // _BottomNavBarItem(
          //   icon: 'assets/images/Question Bank.png',
          //   isSelected: 1 == currentIndex,
          //   label: 'Qbank',
          //   onTap: onTapQbank,
          // ),
          _MainBottomNavBarItem(
            icon: 'assets/images/Expert Solutions.png',
            isSelected: 2 == currentIndex,
            label: 'Expert Solutions',
            onTap: onTapExpertSolution,
          ),
          _BottomNavBarItem(
            icon: 'assets/images/Shop.png',
            isSelected: 3 == currentIndex,
            label: 'Shop',
            onTap: onTapMarketplace,
          ),
          _BottomNavBarItem(
            icon: 'assets/images/Settings.png',
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
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String icon;

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
                width: 24,
                height: 24,
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
                width: 28,
                height: 28,
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
