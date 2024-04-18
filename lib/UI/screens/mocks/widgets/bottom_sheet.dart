import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/screens/mocks/widgets/deck_instructions.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../../../models/deck_group_model.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.deckGroup});

  final DeckGroupModel deckGroup;

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
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.deckGroup.deckItems.length,
            itemBuilder: (context, index) {
              final DeckItem item = widget.deckGroup.deckItems[index];
              return Container(
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    backgroundImage: widget.deckGroup.deckItems[index].deckLogo
                            .toLowerCase()
                            .endsWith('.svg')
                        ? SvgPicture.network(
                            widget.deckGroup.deckItems[index].deckLogo,
                            placeholderBuilder: (BuildContext context) =>
                                const CircularProgressIndicator(),
                          ) as ImageProvider
                        : NetworkImage(widget.deckGroup.deckItems[index].deckLogo)
                            as ImageProvider,
                  ),
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
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.deckGroup.deckItems[index].premiumTag,
                              style: PreMedTextTheme().body.copyWith(
                                  color: PreMedColorTheme().white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ))
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  DeckInstructions(deckInstructions: item.deckInstructions, deckGroup: widget.deckGroup, selectedIndex:selectedDeckItemIndex,),
                        ),
                      );
                    },

                  ),
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
