import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:provider/provider.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfScreen> {
  String b =
      'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/f16f2eff-0dbb-4ebc-bc66-b88f3a2dcfdf.pdf';
  String s1 =
      'https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/6c7a7004-e10e-4e21-b9bb-1808daa39080.pdf';
  String s2 =
      'https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/Notes/Enzymes%20(5)-compressed_compressed%20(1).pdf';
  int currentPage = 0;
  int maxPage = 100; // Change this to the maximum page count in your PDF
  late PDFViewController pdfController;

  @override
  Widget build(BuildContext context) {
    PdfUrlProvider p = Provider.of<PdfUrlProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () async {
                p.url = b;
                Navigator.of(context).pop();
                currentPage = 0;
                pdfController.setPage(currentPage);
              },
              title: Text("Sample 0"),
            ),
            ListTile(
              onTap: () async {
                p.url = s1;
                Navigator.of(context).pop();
                currentPage = 0;
                pdfController.setPage(currentPage);
              },
              title: Text("Sample 1"),
            ),
            ListTile(
              onTap: () async {
                p.url = s2;
                Navigator.of(context).pop();
                currentPage = 0;
                pdfController.setPage(currentPage);
              },
              title: const Text("Sample 2"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          PDF(
            swipeHorizontal: true,
            onViewCreated: (PDFViewController controller) {
              pdfController = controller;
            },
          ).cachedFromUrl(p.url),
          Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: currentPage > 0
                        ? () {
                            setState(() {
                              currentPage--;
                              pdfController.setPage(currentPage);
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: PreMedColorTheme().white,
                      disabledBackgroundColor: PreMedColorTheme().white,
                      backgroundColor: PreMedColorTheme().white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                        Text(
                          "Previous",
                          style: PreMedTextTheme()
                              .subtext
                              .copyWith(color: PreMedColorTheme().neutral500),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$currentPage",
                  ),
                  ElevatedButton(
                    onPressed: currentPage < maxPage
                        ? () {
                            setState(() {
                              currentPage++;
                              pdfController.setPage(currentPage);
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PreMedColorTheme().primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Next",
                          style: PreMedTextTheme()
                              .subtext
                              .copyWith(color: PreMedColorTheme().white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: PreMedColorTheme().white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pd() async => await Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => PdfScreen()));
}

class PdfUrlProvider with ChangeNotifier {
  String _url = 'http://africau.edu/images/default/sample.pdf';
  String get url => _url;
  set url(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }
}
