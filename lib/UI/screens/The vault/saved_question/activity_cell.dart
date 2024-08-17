import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/models/saved_question_model.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/premed_provider.dart';

class ActivityCell extends StatelessWidget {
  const ActivityCell({super.key, required this.savedQuestionModel});
  final SavedQuestionModel savedQuestionModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(Provider.of<PreMedProvider>(context).isPreMed
                ? PremedAssets.RedDocument
                : PremedAssets.BlueDocument),
            const SizedBox(width: 16.0), //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, //
                children: [
                  Text(
                    savedQuestionModel.question,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: savedQuestionModel.tags
                        .map((tag) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 20.0,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFE86340)
                                        .withOpacity(0.25),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tag,
                                      style: PreMedTextTheme()
                                          .heading1
                                          .copyWith(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            color: Provider.of<PreMedProvider>(
                                                        context)
                                                    .isPreMed
                                                ? PreMedColorTheme()
                                                    .primaryColorRed
                                                : PreMedColorTheme().blue,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    savedQuestionModel.createdAt,
                    style: PreMedTextTheme().heading1.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBoxes.vertical3Px,
        Divider(
          color: const Color.fromARGB(255, 56, 56, 56).withOpacity(0.6),
          thickness: 1,
        ),
      ],
    );
  }
}
