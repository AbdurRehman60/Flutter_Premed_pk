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
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 3,
        mainAxisExtent: 300, // Number of columns in the grid
      ),
      // shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return PDFTile(imageUrl: imageUrl, title: title, pages: pages);
      },
    );
  }
}

class PDFTile extends StatelessWidget {
  const PDFTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.pages,
  });

  final String imageUrl;
  final String title;
  final int pages;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              height: 200,
              width: 142,
              fit: BoxFit.contain,
            ),
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
  }
}
