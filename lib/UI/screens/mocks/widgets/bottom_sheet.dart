import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/test_mode_page.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import '../../../../models/deck_group_model.dart';
import '../../qbank/widgets/logo_avatar.dart';
import 'deck_instructions.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet(
      {super.key, required this.deckGroup, required this.bankOrMock, required this.qbankGroupName});
  final String bankOrMock;

  final DeckGroupModel deckGroup;
  final String? qbankGroupName;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late int selectedDeckItemIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 8,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: PreMedColorTheme().neutral400,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.deckGroup.deckItems.length,
                itemBuilder: (context, index) {
                  final DeckItem item = widget.deckGroup.deckItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: GetLogo(url: widget.deckGroup.deckItems[index].deckLogo),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.deckGroup.deckItems[index].deckName,
                            style: PreMedTextTheme().body.copyWith(
                                color: PreMedColorTheme().black,
                                fontWeight: FontWeight.w700,
                                fontSize: 17),
                          ),
                          SizedBoxes.verticalTiny,
                          if (widget.deckGroup.deckItems[index].premiumTag != null)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: PreMedColorTheme().primaryColorRed,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.deckGroup.deckItems[index].premiumTag!,
                                  style: PreMedTextTheme().body.copyWith(
                                      color: PreMedColorTheme().white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: PreMedColorTheme().primaryColorRed,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedDeckItemIndex = index;
                          });
                          widget.bankOrMock == 'Bank'
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestModeInterface(
                                    deckDetails: {
                                      'deckName': widget.deckGroup
                                          .deckItems[index].deckName,
                                      'isTutorModeFree': widget
                                          .deckGroup
                                          .deckItems[index]
                                          .isTutorModeFree,
                                      'deckInstructions': widget
                                          .deckGroup
                                          .deckItems[index]
                                          .deckInstructions,
                                      'questions': '2',
                                      'timedTestMinutes': widget
                                          .deckGroup
                                          .deckItems[index]
                                          .timesTestminutes,
                                    },
                                    deckGroupName: widget.qbankGroupName ?? '')),
                          )
                              : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeckInstructions(
                                deckInstructions: item.deckInstructions,
                                deckGroup: widget.deckGroup,
                                selectedIndex: selectedDeckItemIndex,
                              ),
                            ),
                          );
                        },
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
