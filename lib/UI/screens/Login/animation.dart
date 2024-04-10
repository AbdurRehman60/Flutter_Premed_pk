import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';

class MovingRowAnimation extends StatefulWidget {
  @override
  _MovingRowAnimationState createState() => _MovingRowAnimationState();
}

class _MovingRowAnimationState extends State<MovingRowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      left: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 0,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Pre-Medical', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'Private Universities', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Study Notes', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'NUMS', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Study Notes', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'NUMS', textColor: PreMedColorTheme().tickcolor),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      right: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 40,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'MDCAT', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Test Sessions', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'The Vault', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'Guide', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Shortlistings', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'F.Sc', textColor: PreMedColorTheme().white),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      left: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 80,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().neutral100, text: 'AKU', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Doubt Solve', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'Flashcards', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'NUMS', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Study Notes', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'Qbank', textColor: PreMedColorTheme().white),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      right: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 120,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'Real-time Satistics', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'AKU', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Solution', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'Flashcards', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'Expert Solutions', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Study Notes', textColor: PreMedColorTheme().white),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      left: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 160,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Pre-Medical', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'Private Universities', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Study Notes', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'NUMS', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Study Notes', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'NUMS', textColor: PreMedColorTheme().tickcolor),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      right: MediaQuery.of(context).size.width * (_animation.value - 1),
                      top: 200,
                      child: Row(
                        children: [
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'Pre-Medical', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Private Universities', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorRed, text: 'Study Notes', textColor: PreMedColorTheme().white),
                          Tile(color: PreMedColorTheme().customCheckboxColor, text: 'NUMS', textColor: PreMedColorTheme().tickcolor),
                          Tile(color: PreMedColorTheme().neutral100, text: 'Study Notes', textColor: PreMedColorTheme().primaryColorRed),
                          Tile(color: PreMedColorTheme().primaryColorBlue, text: 'NUMS', textColor: PreMedColorTheme().white),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                top: 90,
                left: 60,
                child: Opacity(
                  opacity: 0.75,
                  child: Container(
                    width: 260,
                    height: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 75,
                left: 20,
                child: Image.asset(
                  'assets/images/premedanimation.png',
                  width: 340,
                  height: 140,
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;

  const Tile({required this.color, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}