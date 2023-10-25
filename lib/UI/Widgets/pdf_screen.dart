import 'dart:async';

import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfScreen extends StatefulWidget {
  final Note note;
  const PdfScreen({
    super.key,
    required this.note,
  });
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfScreen> {
  int currentPage = 1;
  int maxPage = 0; // Change this to the maximum page count in your PDF
  PDFViewController? pdfController;
  Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  @override
  Widget build(BuildContext context) {
    // PdfUrlProvider p = Provider.of<PdfUrlProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        iconTheme: IconThemeData(color: PreMedColorTheme().primaryColorRed),
        title: Text(
          widget.note.title,
          style: PreMedTextTheme().subtext,
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       ListTile(
      //         onTap: () async {
      //           p.url = b;
      //           Navigator.of(context).pop();
      //           currentPage = 0;
      //           pdfController!.setPage(currentPage);
      //         },
      //         title: Text("Sample 0"),
      //       ),
      //       ListTile(
      //         onTap: () async {
      //           p.url = s1;
      //           Navigator.of(context).pop();
      //           currentPage = 0;
      //           pdfController!.setPage(currentPage);
      //         },
      //         title: Text("Sample 1"),
      //       ),
      //       ListTile(
      //         onTap: () async {
      //           p.url = s2;
      //           Navigator.of(context).pop();
      //           currentPage = 0;
      //           pdfController!.setPage(currentPage);
      //         },
      //         title: const Text("Sample 2"),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PDF(
          fitPolicy: FitPolicy.BOTH,
          autoSpacing: false,
          pageSnap: false,
          onViewCreated: (PDFViewController pdfViewController) async {
            _pdfViewController.complete(pdfViewController);
            final int cp = await pdfViewController.getCurrentPage() ?? 0;
            final int? pc = await pdfViewController.getPageCount();

            setState(() {
              currentPage = cp;
              maxPage = pc!;
            });
          },
        ).cachedFromUrl(
          widget.note.notesURL,
          placeholder: (double progress) => Center(child: Text('$progress %')),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: currentPage > 0
                  ? () {
                      setState(() {
                        currentPage--;
                        pdfController?.setPage(currentPage);
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
                  const Icon(
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
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PreMedColorTheme().neutral200),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "$currentPage",
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().neutral100,
                    border: Border(
                      top: BorderSide(color: PreMedColorTheme().neutral200),
                      right: BorderSide(color: PreMedColorTheme().neutral200),
                      bottom: BorderSide(color: PreMedColorTheme().neutral200),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      maxPage.toString(),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: currentPage < maxPage
                  ? () {
                      setState(() {
                        currentPage++;
                        pdfController?.setPage(currentPage);
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
    );
  }

  // Future<void> pd() async => await Navigator.of(context)
  //     .pushReplacement(MaterialPageRoute(builder: (context) => PdfScreen()));
}

// class PdfUrlProvider with ChangeNotifier {
//   String _url = 'http://africau.edu/images/default/sample.pdf';
//   String get url => _url;
//   set url(String newUrl) {
//     _url = newUrl;
//     notifyListeners();
//   }
// }
