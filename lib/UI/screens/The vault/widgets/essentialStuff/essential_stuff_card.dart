import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import '../../../../../constants/constants_export.dart';

class EssenStuffCard extends StatelessWidget {
  const EssenStuffCard(
      {super.key, required this.essenStuffModel, required this.onTap});
  final EssenceStuffModel essenStuffModel;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 163,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.50)),
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Downloadable Resources'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: PreMedTextTheme().heading1.copyWith(
                      fontSize: 6,
                      fontWeight: FontWeight.w800,
                      color: Colors.black26,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  essenStuffModel.topicName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PreMedTextTheme().heading1.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                ),
              ),
              Text(
                essenStuffModel.board,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: PreMedTextTheme().heading1.copyWith(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
