import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/ask_an_expert_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class AskanExpert extends StatelessWidget {
  const AskanExpert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: 37,
              height: 37,
              child: SvgPicture.asset(
                'assets/icons/left-arrow.svg',
                width: 9.33,
                height: 18.67,
              ),
            ),
          ),
        ),
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
