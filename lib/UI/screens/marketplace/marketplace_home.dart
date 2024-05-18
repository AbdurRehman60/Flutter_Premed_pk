import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_drawer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({super.key});

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }


  @override
  Widget build(BuildContext context) {
    final BundleProvider bundleProvider =
        Provider.of<BundleProvider>(context, listen: false);
    bundleProvider.fetchBundles();
    bundleProvider.fetchDiscount();
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 6.0, top: 28, bottom: 28),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop',
                          style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 34, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Explore and Buy PreMed Bundles!',
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalLarge,
                  ],
                ),
              ),
              actions: [
                Builder(
                  builder: (BuildContext builderContext) => const TextButton(
                    onPressed: openDrawer,
                    child: CartIcon(),
                  ),
                ),
              ],
              centerTitle: false,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(14, 0, 0, 0),
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarDividerColor: Colors.white,
              )),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const CountdownTimerWidget(),
                  SizedBoxes.verticalMedium,
                  const SpecialOffers(),
                  //SizedBoxes.verticalMedium,
                ],
              ),
            ),
            const MarketplaceTabView(),
          ],
        ),
      ),
      endDrawer: const CartDrawer(),
    );
  }
}
