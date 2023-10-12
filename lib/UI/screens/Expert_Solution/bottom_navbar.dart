import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xFFEC5863), // Color for the selected tab
            unselectedItemColor: Color(0xFF71717A), // Color for unselected tabs
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library),
                label: 'Video',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'About',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: 'Phone',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
