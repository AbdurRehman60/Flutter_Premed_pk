import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/export.dart';

class ProvincialGuides extends StatelessWidget {
  const ProvincialGuides({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(PremedAssets.EsIcon),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Provincial Guides',
                    style: PreMedTextTheme()
                        .heading6
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ],
              ),
              const Icon(
                Icons.search,
                color: Colors.white,
              )
            ],
          ),
          bottom: TabBar(
            isScrollable: true, // Make tabs scrollable
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Sindh'),
              Tab(text: 'Punjab'),
              Tab(text: 'Balochistan'),
              Tab(text: 'KPK'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for 'All' tab
            PdfDisplay(
              imageUrl:
                  'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png',
              title: 'Biology and its major fields of specialization',
              pages: 7,
            ),
            PdfDisplay(
              imageUrl:
                  'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png',
              title: 'Biology and its major fields of specialization',
              pages: 7,
            ),
            PdfDisplay(
              imageUrl:
                  'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png',
              title: 'Biology and its major fields of specialization',
              pages: 7,
            ),
            PdfDisplay(
              imageUrl:
                  'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png',
              title: 'Biology and its major fields of specialization',
              pages: 7,
            ),
            PdfDisplay(
              imageUrl:
                  'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png',
              title: 'Biology and its major fields of specialization',
              pages: 7,
            ),
          ],
        ),
      ),
    );
  }
}
