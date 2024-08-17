import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/ask_an_expert_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class AskanExpert extends StatelessWidget {
  const AskanExpert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().background,
        leading: const PopButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ask an Expert',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black, fontWeight: FontWeight.bold),
            ),
            SizedBoxes.vertical2Px,
            Text('EXPERT SOLUIONS',
                style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PreMedColorTheme().black,
                    ))
          ],
        ),
      ),
      body: AskanExpertForm(),
    );
  }
}
