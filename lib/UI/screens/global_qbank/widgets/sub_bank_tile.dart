import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/logo_avatar.dart';

import '../../../../constants/constants_export.dart';

class SubBankTile extends StatelessWidget {
  const SubBankTile({Key? key, required this.onTap, required this.details})
      : super(key: key);
  final Map<String, dynamic> details;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          tileColor: Colors.grey.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: GetLogo(url: details['deckLogo']),
          title: Text(details['deckName']), // subtitle: Text('${qbank.deckGroupLenght.toString()} Papers'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
