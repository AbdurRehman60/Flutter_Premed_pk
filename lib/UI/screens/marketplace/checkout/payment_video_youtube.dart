import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PaymentVideo extends StatelessWidget {
  const PaymentVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.verticalMedium,
            Text(
              'Video Instructions',
              style: PreMedTextTheme().heading5,
            ),
            SizedBoxes.verticalMedium,
            // const MyYoutubePlayer(),
            SizedBoxes.verticalMedium,
          ],
        ),
      ),
    );
  }
}
