import 'package:premedpk_mobile_app/constants/constants_export.dart';

class TypingTextAnimation extends StatefulWidget {
  const TypingTextAnimation({super.key});

  @override
  _TypingTextAnimationState createState() => _TypingTextAnimationState();
}

class _TypingTextAnimationState extends State<TypingTextAnimation> {
  late TextEditingController _textController;
  late Timer _timer;
  int _currentLength = 0;
  final String _targetText =
      'Sign up for Free Chapter Guides and Exclusive PreMed Notes!';

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _timer = Timer.periodic(
        const Duration(
          milliseconds: 35,
        ),
        _typeText);
  }

  @override
  void dispose() {
    _timer.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _typeText(Timer timer) {
    if (_currentLength <= _targetText.length) {
      setState(() {
        _textController.text = _targetText.substring(0, _currentLength);
        _currentLength++;
      });
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        maxLines: 3,
        controller: _textController,
        readOnly: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: PreMedTextTheme()
            .heading3
            .copyWith(color: PreMedColorTheme().white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
