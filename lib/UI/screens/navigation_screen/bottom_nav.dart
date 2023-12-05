import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PremedBottomNav extends StatelessWidget {
  const PremedBottomNav(
      {Key? key,
      required this.currentIndex,
      required this.onTapHome,
      required this.onTapMarketplace,
      required this.onTapFlashcards,
      required this.onTapExpertSolution,
      required this.onTapProfile})
      : super(key: key);

  final int currentIndex;
  final VoidCallback onTapHome;
  final VoidCallback onTapMarketplace;
  final VoidCallback onTapFlashcards;
  final VoidCallback onTapExpertSolution;
  final VoidCallback onTapProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavBarItem(
            icon: Icons.home,
            isSelected: 0 == currentIndex,
            label: 'Home',
            onTap: onTapHome,
          ),
          _BottomNavBarItem(
            icon: Icons.bookmarks_rounded,
            isSelected: 1 == currentIndex,
            label: 'Flashcards',
            onTap: onTapFlashcards,
          ),
          _MainBottomNavBarItem(
            icon: Icons.shopping_bag,
            isSelected: 2 == currentIndex,
            label: 'Marketplace',
            onTap: onTapMarketplace,
          ),
          _BottomNavBarItem(
            icon: Icons.play_circle_fill_outlined,
            isSelected: 3 == currentIndex,
            label: 'Expert Solution',
            onTap: onTapExpertSolution,
          ),
          _BottomNavBarItem(
            icon: Icons.person_2,
            isSelected: 4 == currentIndex,
            label: 'Profile',
            onTap: onTapProfile,
          ),
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: PreMedColorTheme().white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? PreMedColorTheme().primaryColorRed
                      : PreMedColorTheme().neutral200,
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
      ),
    );
  }
}

class _MainBottomNavBarItem extends StatelessWidget {
  const _MainBottomNavBarItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? PreMedColorTheme().primaryColorRed100
                  : PreMedColorTheme().primaryColorRed,
              border: Border.all(
                color: isSelected
                    ? PreMedColorTheme().primaryColorRed200
                    : PreMedColorTheme().primaryColorRed,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? PreMedColorTheme().primaryColorRed
                        : PreMedColorTheme().white,
                  ),
                  // Text(
                  //   label,
                  //   style: PreMedTextTheme().small,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
