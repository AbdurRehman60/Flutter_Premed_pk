import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.imageAddress,
  });

  final String title;
  final void Function() onTap;
  final String imageAddress;

  @override
  Widget build(BuildContext context) {
    final PreMedProvider preMedProvider = Provider.of<PreMedProvider>(context);
    return Container(
      height: 108,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.white.withOpacity(0.5)),
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff26000000),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Center(
        child: ListTile(

            contentPadding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Image.asset(
              imageAddress,
              height: 30,
            ),
            title: Text(
              title,
              style: PreMedTextTheme()
                  .body1
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            trailing: IconButton(
              onPressed: onTap,
              icon: Icon(Icons.arrow_forward_ios_rounded,
                  color: preMedProvider.isPreMed ? PreMedColorTheme().primaryColorRed : PreMedColorTheme().blue),
            )),
      ),
    );
  }
}
