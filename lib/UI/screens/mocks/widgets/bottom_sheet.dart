import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      padding:const EdgeInsets.all(16.0),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ],
      ),
    );
  }
}
