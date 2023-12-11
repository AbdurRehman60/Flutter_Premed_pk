import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/payment_tile.dart';
import 'package:premedpk_mobile_app/UI/widgets/youtube_player/youtube_player.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

final Map<String, dynamic> meezanNumbers = {
  'Fahad Niaz Sheikh': '99170105642737',
  'IBAN #': 'PK50MEZN0099170105642737'
};

final Map<String, dynamic> easyPaisaNumbers = {
  'Khwaja Muhammed Haiyaan': '0331-2176647',
  'Fahd Niaz Shaikh': '0336-2542685',
};

final Map<String, dynamic> jazzCashNumbers = {
  'Khwaja Muhammed Haiyaan': '0331-2176647',
};

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final RadioGroup<int> paymentRadioGroup = RadioGroup<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black,
        ),
        backgroundColor: PreMedColorTheme().white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 0,
                paymentProvider: "Bank Transfer",
                image: PremedAssets.Meezan,
                numbers: meezanNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 0
                        ? paymentRadioGroup.setSelectedValue(0)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 1,
                paymentProvider: "Easy Paisa",
                image: PremedAssets.EasyPaisa,
                numbers: easyPaisaNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 1
                        ? paymentRadioGroup.setSelectedValue(1)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 2,
                paymentProvider: "Jazz Cash",
                image: PremedAssets.JazzCash,
                numbers: jazzCashNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 2
                        ? paymentRadioGroup.setSelectedValue(2)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How to pay',
                        style: PreMedTextTheme().heading5,
                      ),
                      Text(
                        'Zoom-in to view',
                        style: PreMedTextTheme().headline.copyWith(
                            color: PreMedColorTheme().neutral400,
                            fontWeight: FontWeights.regular),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: PreMedColorTheme().neutral300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(8.0),
                        minScale: 0.5,
                        maxScale: 4.0,
                        scaleEnabled: true,
                        child: Image.asset(
                          PremedAssets.HowtoPay,
                        ),
                      ),
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    'Video Instructions',
                    style: PreMedTextTheme().heading5,
                  ),
                  SizedBoxes.verticalMedium,
                  const MyYoutubePlayer(),
                  SizedBoxes.verticalMedium,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioGroup<T> {
  T? _selectedValue;

  T? get selectedValue => _selectedValue;

  void setSelectedValue(T value) {
    _selectedValue = value;
  }
}
