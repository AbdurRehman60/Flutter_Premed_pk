import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offer_shimmer.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:provider/provider.dart';

class DoubtListView extends StatelessWidget {
  const DoubtListView({
    super.key,
    required this.solved,
  });

  final bool solved;
  @override
  Widget build(BuildContext context) {

    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(
      context,
    );
    final List<Doubt> doubtList = askAnExpertProvider.solvedDoubts
        .where((doubt) => solved
            ? doubt.solvedStatus == 'Solved'
            : doubt.solvedStatus != 'Solved')
        .toList();

    return askAnExpertProvider.fetchDoubtsStatus == Status.Success
        ? doubtList.isNotEmpty
            ? ListView.builder(
                itemCount: doubtList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0) const SizedBox(
                                height: 140,
                              ) else const SizedBox(),
                        DoubtCard(
                          doubt: doubtList[index],
                        ),
                        Divider(
                          thickness: 1,
                          color: PreMedColorTheme().neutral300,
                        ),
                      ],
                    ),
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
              )
        : const Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Expanded(
                child: SpecialOffersShimmer(
                  tabCard: true,
                  cardCount: 4,

                ),
              ),
            ],
          );
  }
}
