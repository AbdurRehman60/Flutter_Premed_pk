import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  State<PdfScreen> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfScreen> {
  int currentPage = 0;
  int maxPage = 0;
  bool isDownloading = false;

  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  void dispose() {
    _pageCountController
        .close(); // Don't forget to close the stream controller.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void openDemarcationBottomSheet() {
      showModalBottomSheet(
        context: context,
        backgroundColor: PreMedColorTheme().white,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 72,
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().neutral200,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                SizedBoxes.vertical2Px,
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CONTENTS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PreMedColorTheme().neutral900,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.note.demarcations?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();

                          _pdfViewController.future.then(
                                (controller) {
                              final int pageNumber =
                                  widget.note.demarcations![index].page;

                              if (pageNumber >= 0 && pageNumber < maxPage) {
                                controller.setPage(pageNumber - 1);
                              }
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Image.asset(
                              'assets/images/content.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBoxes.horizontalLarge,
                            Expanded(
                              child: Text(
                                widget.note.demarcations![index].name,
                                style: PreMedTextTheme().body.copyWith(
                                    fontSize: 16,
                                    fontWeight: currentPage ==
                                        widget
                                            .note.demarcations![index].page
                                        ? FontWeight.w700
                                        : FontWeight.w700,
                                    color: currentPage ==
                                        widget
                                            .note.demarcations![index].page
                                        ? PreMedColorTheme().primaryColorRed
                                        : PreMedColorTheme().neutral900),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return StreamBuilder<String>(
      stream: _pageCountController.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: PreMedColorTheme().white,
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: PreMedColorTheme().primaryColorRed),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.note.title,
                          style: PreMedTextTheme().subtext.copyWith(
                            color: PreMedColorTheme().black,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('REVISION NOTES',
                            style: PreMedTextTheme().subtext.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: PreMedColorTheme().black,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // actions: [
            //   if (Platform.isAndroid)
            //     IconButton(
            //       onPressed: () {
            //         if (!isDownloading) {
            //           FileDownloader.downloadFile(
            //             url: widget.note.notesURL.trim(),
            //             name: '${widget.note.title.trim()}_PreMed.PK',
            //             notificationType: NotificationType.all,
            //             onDownloadRequestIdReceived: (downloadId) {
            //               setState(() {
            //                 isDownloading = true;
            //               });
            //             },
            //             onDownloadCompleted: (path) {
            //               setState(() {
            //                 isDownloading = false;
            //               });
            //               showSnackbar(
            //                 context,
            //                 "Download Complete",
            //                 SnackbarType.SUCCESS,
            //               );
            //             },
            //             onDownloadError: (errorMessage) {
            //               setState(() {
            //                 isDownloading = false;
            //               });
            //               showSnackbar(
            //                 context,
            //                 errorMessage,
            //                 SnackbarType.INFO,
            //               );
            //             },
            //           );
            //         }
            //       },
            //       icon: isDownloading
            //           ? const SizedBox(
            //               width: 20,
            //               height: 20,
            //               child: CircularProgressIndicator(
            //                 strokeWidth: 2.5,
            //               ))
            //           : Icon(
            //               Icons.check_circle,
            //               size: 24,
            //               color: PreMedColorTheme().tickcolor,
            //             ),
            //     )
            //   else
            //     const SizedBox(),
            //   // if (!widget.note.isGuide)
            //   //   IconButton(
            //   //     onPressed: openDemarcationBottomSheet,
            //   //     icon: const Icon(Icons.menu),
            //   //   )
            //   // else
            //   //   const SizedBox(),
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: PDF(
              fitPolicy: FitPolicy.BOTH,
              pageSnap: false,
              autoSpacing: false,
              onPageChanged: (int? current, int? total) {
                currentPage = current! + 1;
                _pageCountController.add('${currentPage + 1} - $total');
              },
              onViewCreated: (PDFViewController pdfViewController) async {
                _pdfViewController.complete(pdfViewController);
                await Future.delayed(
                  const Duration(milliseconds: 150),
                );
                final int current =
                    await pdfViewController.getCurrentPage() ?? 0;
                final int? pageCount = await pdfViewController.getPageCount();

                setState(() {
                  currentPage = current + 1;
                  maxPage = pageCount ?? 2;
                });

                _pageCountController.add('${currentPage + 1} - $maxPage');
              },
            ).cachedFromUrl(
              widget.note.notesURL,
              placeholder: (double progress) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'animations/1.json',
                    height: 200,
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                  Text('$progress %'),
                ],
              ),
              errorWidget: (dynamic error) => Center(
                child: Center(
                  child: EmptyState(
                      displayImage: PremedAssets.Notfoundemptystate,
                      title: 'Oops! Something Went Wrong',
                      body:
                      "We're having trouble fetching the PDF right now. Please try again later, and we hope to have it ready for you soon."),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: PreMedColorTheme().primaryColorBlue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Visibility(
                      visible: !widget.note.isGuide,
                      child: GestureDetector(
                        onTap: () {
                          openDemarcationBottomSheet();
                        },
                        child: Image.asset(
                          'assets/images/Menu.png',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Text(
                          "$currentPage",
                          style: PreMedTextTheme().headline.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'of',
                        style: PreMedTextTheme().headline.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Text(
                          maxPage.toString(),
                          style: PreMedTextTheme().headline.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: PreMedColorTheme().white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: PreMedColorTheme().primaryColorRed)),
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/Vector.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}