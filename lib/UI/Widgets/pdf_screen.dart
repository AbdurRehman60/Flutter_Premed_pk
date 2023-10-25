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
  int currentPage = 0;
  int maxPage = 100; // Change this to the maximum page count in your PDF
  PDFViewController? pdfController;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  @override
  Widget build(BuildContext context) {
    // PdfUrlProvider p = Provider.of<PdfUrlProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        iconTheme: IconThemeData(color: PreMedColorTheme().primaryColorRed),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 275,
                  child: Text(
                    widget.note.title,
                    style: PreMedTextTheme().subtext,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            // Add an empty container as a placeholder
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0;
                              i < widget.note.demarcations.length;
                              i++)
                            ListTile(
                              onTap: () async {
                                Navigator.of(context).pop();
                                currentPage = widget.note.demarcations[i].page;
                                pdfController!.setPage(currentPage);
                              },
                              title: Text(widget.note.demarcations[i].name),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.menu),
            )
          ],
        ),
      ),
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
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ElevatedButton(
            //   onPressed: currentPage > 0
            //       ? () {
            //           setState(() {
            //             currentPage--;
            //             pdfController?.setPage(currentPage);
            //           });
            //         }
            //       : null,
            //   style: ElevatedButton.styleFrom(
            //     surfaceTintColor: PreMedColorTheme().white,
            //     disabledBackgroundColor: PreMedColorTheme().white,
            //     backgroundColor: PreMedColorTheme().white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.arrow_back_ios,
            //         size: 15,
            //       ),
            //       Text(
            //         "Previous",
            //         style: PreMedTextTheme()
            //             .subtext
            //             .copyWith(color: PreMedColorTheme().neutral500),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
                height: 40,
                width: 120,
                child: CustomButton(
                    textColor: PreMedColorTheme().neutral500,
                    color: PreMedColorTheme().white,
                    isOutlined: false,
                    isIconButton: true,
                    leftIcon: true,
                    iconSize: 15,
                    icon: Icons.arrow_back_ios,
                    buttonText: 'Previous',
                    onPressed: () {})),
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
            SizedBox(
                height: 40,
                width: 120,
                child: CustomButton(
                    textColor: PreMedColorTheme().white,
                    color: PreMedColorTheme().primaryColorRed,
                    isOutlined: false,
                    isIconButton: true,
                    leftIcon: false,
                    iconSize: 15,
                    icon: Icons.arrow_forward_ios,
                    buttonText: 'Next',
                    onPressed: () {}))
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
