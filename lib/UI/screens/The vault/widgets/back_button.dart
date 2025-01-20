import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants_export.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isPreMed = Provider.of<PreMedProvider>(context).isPreMed;
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        width: 50,
        height: 50,
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
            size: 24,
          ),
        ),
      ),
    );
  }
}
