import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class PdfDisplay extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int pages;

  PdfDisplay({
    required this.imageUrl,
    required this.title,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10, // You only have one item per grid cell
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 200,
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                imageUrl,
                width: 142,
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBoxes.verticalMedium,
              Text(
                title,
                style: PreMedTextTheme().headline,
                textAlign: TextAlign.center,
              ),
              SizedBoxes.verticalMicro,
              Text(
                '$pages Pages',
                textAlign: TextAlign.center,
                style: PreMedTextTheme().small.copyWith(
                      color: PreMedColorTheme().neutral400,
                    ),
              ),
              SizedBoxes.verticalLarge
            ],
          ),
        );
      },
    );
  }
}
