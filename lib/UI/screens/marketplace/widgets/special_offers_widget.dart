import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/modal_bottom_sheet.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offer_shimmer.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Text(
            'Special Offers',
            style: PreMedTextTheme().heading6,
          ),
        ),
        //SizedBoxes.verticalBig,
        SizedBox(
          // height: MediaQuery.of(context).size.height * 0.3,
          height: 330,
          child: Consumer<BundleProvider>(
            builder: (context, bundleProvider, _) {
              final List<BundleModel> filteredList = bundleProvider.bundleList
                  .where((bundle) => bundle.includedTags.length >= 2)
                  .toList();
              filteredList.sort((a, b) => a.position.compareTo(b.position));
              return bundleProvider.loadingStatus == Status.Success
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 0, right: 20),
                    child: SpecialOfferCard(bundle: filteredList[index]),
                  );
                },
              )
                  : const SpecialOffersShimmer();
            },
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.bundle,
  });

  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ModalSheetWidget(bundle: bundle);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          // margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: PreMedColorTheme().white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
            //border: Border.all(color: Colors.white, width: 4, ),
          ),

          child: CardContent(
            bundle: bundle,
            renderPoints: false,
          ),
        ),
      ),
    );
  }
}

Widget buildBundleIcon(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.contain,
    width: 36,
    height: 36,
    errorBuilder: (context, error, stackTrace) {
      return Image.network(
        "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/CustomImages/PreMedCircleLogo.cffae65f.png",
        fit: BoxFit.contain,
        width: 36,
        height: 36,
      );
    },
  );
}
