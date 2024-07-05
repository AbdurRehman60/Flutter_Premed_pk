import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 16),
          child: Transform.scale(
            scale: 10.0,
            child: Image.asset(
              PremedAssets.Cart,
              width: 30,
              height: 31,
            ),
          ),
        ),
      ],
    );
  }
}
