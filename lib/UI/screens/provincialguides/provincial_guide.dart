import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';
import 'package:premedpk_mobile_app/utils/Data/notesdata.dart';

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
          bottom: const TabBar(
          bottom: const TabBar(
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: TabBarView(
            children: [
              PdfDisplay(notes: notesData),
              PdfDisplay(notes: notesData),
              PdfDisplay(notes: notesData),
              PdfDisplay(notes: notesData),
              PdfDisplay(notes: notesData),
            ],
          ),
        ),
      ),
    );
  }
}
