import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants_export.dart';

class TopicButton extends StatelessWidget {
  const TopicButton({
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
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.5),
          backgroundColor: isActive
              ? (Provider.of<PreMedProvider>(context).isPreMed
                  ? const Color(0xFFEC5863)
                  : PreMedColorTheme().blue)
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0x80FFFFFF),
              width: 3.0,
            ),
          ),
          elevation: 1,
        ),
        onPressed: onTap,
        child: Text(
          topicName,
          style: PreMedTextTheme().heading1.copyWith(
              color: isActive ? Colors.white : const Color(0xFF4E4B66),
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
