import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shimmer/shimmer.dart';

class SpecialOffersShimmer extends StatelessWidget {
  final bool tabCard;
  final int cardCount;
  const SpecialOffersShimmer({
    super.key,
    this.tabCard = false,
    this.cardCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: PreMedColorTheme().neutral200,
      highlightColor: PreMedColorTheme().neutral50,
      child: ListView.builder(
        scrollDirection: tabCard ? Axis.vertical : Axis.horizontal,
        itemCount: cardCount, // You can adjust the number of shimmer items
        itemBuilder: (context, index) {
          return Container(
            margin: tabCard
                ? EdgeInsets.only(
                    left: 20, right: 20, top: index == 0 ? 16 : 8, bottom: 0)
                : EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
            child: ShimmerSpecialOfferCard(
              tabCard: tabCard,
            ),
          );
        },
      ),
    );
  }
}

class ShimmerSpecialOfferCard extends StatelessWidget {
  final bool tabCard;
  const ShimmerSpecialOfferCard({super.key, required this.tabCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: tabCard ? 120 : 300,
      margin: EdgeInsets.symmetric(vertical: tabCard ? 0 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }
}
