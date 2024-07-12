import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/addition_model.dart';

class AdditionCard extends StatelessWidget {
  const AdditionCard({super.key, required this.additionModel});

  final AdditionModel additionModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 209,
      height: 93,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.50)),
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 10),
        child: Row(
          children: [
            Container(
              height: 73,
              width: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(additionModel.aditionGrahicUrl),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'video resources'.toUpperCase(),
                    style: PreMedTextTheme().heading1.copyWith(
                          fontSize: 6,
                          fontWeight: FontWeight.w800,
                          color: Colors.black26,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      additionModel.additionTopic.toUpperCase(),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PreMedTextTheme().heading1.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Text(
                    additionModel.additionSubTopic,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: PreMedTextTheme().heading1.copyWith(
                          fontSize: 6,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
