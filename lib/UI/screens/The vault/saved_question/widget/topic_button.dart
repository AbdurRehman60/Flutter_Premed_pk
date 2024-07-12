
import '../../../../../constants/constants_export.dart';

class SavedQuestionTopicButton extends StatelessWidget {
  const SavedQuestionTopicButton({
    super.key,
    required this.topicName,
    required this.onTap,
    required this.isActive,
  });

  final String topicName;
  final void Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            offset: Offset(0, 20),
            blurRadius: 40,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8.5),
          backgroundColor: isActive ? const Color(0xFFEC5863) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0x80FFFFFF),
              width: 3.0,
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          topicName,
          style: PreMedTextTheme().heading1.copyWith(
              color: isActive ? Colors.white : const Color(0xFF4E4B66),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
