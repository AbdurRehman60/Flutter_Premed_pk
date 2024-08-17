import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants_export.dart';
class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isPreMed = Provider.of<PreMedProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 5,
            offset: Offset(1, 7),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: isPreMed.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
