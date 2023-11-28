import 'package:premedpk_mobile_app/constants/constants_export.dart';

class DiscountRow extends StatelessWidget {
  final String title;
  final double? discountPercentage;
  final double price;

  DiscountRow({
    required this.title,
    this.discountPercentage,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: '$title ',
            style: PreMedTextTheme().body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            children: <TextSpan>[
              if (discountPercentage != null)
                TextSpan(
                  text: '(${discountPercentage! * 100}% off)',
                  style: PreMedTextTheme().body.copyWith(
                        fontWeight: FontWeight.w500,
                        color: PreMedColorTheme().primaryColorRed,
                      ),
                ),
            ],
          ),
        ),
        Text(
          '${discountPercentage != null && price > 0 ? '-' : ''}Rs.${price.abs()}',
          style: PreMedTextTheme().body.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
