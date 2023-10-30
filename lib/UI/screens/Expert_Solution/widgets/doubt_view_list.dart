import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';

import '../../../../export.dart';

class DoubtListView extends StatelessWidget {
  const DoubtListView({
    super.key,
    required this.doubtList,
  });

  final List<Doubt> doubtList;

  @override
  Widget build(BuildContext context) {
    return doubtList.isNotEmpty
        ? ListView.builder(
            itemCount: doubtList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index == 0
                      ? const SizedBox(
                          height: 140,
                        )
                      : const SizedBox(),
                  DoubtCard(
                    doubt: doubtList[index],
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: PreMedColorTheme().neutral300,
                  ),
                ],
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(PremedAssets.Notfoundemptystate),
                SizedBoxes.verticalTiny,
                Text(
                  'NO PENDING QUESTIONS',
                  style: PreMedTextTheme().subtext1.copyWith(
                      color: PreMedColorTheme().primaryColorRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.36),
                ),
                SizedBoxes.verticalTiny,
              ],
            ),
          );
  }
}
