import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_drawer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
      appBar: AppBar(
          title: GradientText(
            'PreMed.PK Bundles',
            style: PreMedTextTheme().heading5,
            colors: [
              PreMedColorTheme().primaryColorBlue,
              PreMedColorTheme().primaryColorRed,
            ],
          ),
          iconTheme: IconThemeData(
            color: PreMedColorTheme().black,
          ),
          actions: [
            Builder(
              builder: (BuildContext builderContext) => const TextButton(
                onPressed: openDrawer,
                child: CartIcon(),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(14, 0, 0, 0),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.white,
          )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const CountdownTimerWidget(),
                  SizedBoxes.verticalMedium,
                  const SpecialOffers(),
                  SizedBoxes.verticalMedium,
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
