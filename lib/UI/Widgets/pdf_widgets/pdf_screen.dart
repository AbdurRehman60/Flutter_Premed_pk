import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
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
                          child: Text(
                            widget.note.demarcations![index].name,
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 16,
                                fontWeight: currentPage ==
                                        widget.note.demarcations![index].page
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: currentPage ==
                                        widget.note.demarcations![index].page
                                    ? PreMedColorTheme().primaryColorRed
                                    : PreMedColorTheme().neutral900),
                          ),
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
            iconTheme: IconThemeData(
              color: PreMedColorTheme().primaryColorRed,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.note.title,
                    style: PreMedTextTheme().subtext,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            actions: [
              if (Platform.isAndroid)
                IconButton(
                  onPressed: () {
                    if (!isDownloading) {
                      FileDownloader.downloadFile(
                        url: widget.note.notesURL.trim(),
                        name: '${widget.note.title.trim()}_PreMed.PK',
                        notificationType: NotificationType.all,
                        onDownloadRequestIdReceived: (downloadId) {
                          setState(() {
                            isDownloading = true;
                          });
                        },
                        onDownloadCompleted: (path) {
                          setState(() {
                            isDownloading = false;
                          });
                          showSnackbar(
                            context,
                            "Download Complete",
                            SnackbarType.SUCCESS,
                          );
                        },
                        onDownloadError: (errorMessage) {
                          setState(() {
                            isDownloading = false;
                          });
                          showSnackbar(
                            context,
                            errorMessage,
                            SnackbarType.INFO,
                          );
                        },
                      );
                    }
                  },
                  icon: isDownloading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ))
                      : const Icon(
                          Icons.download,
                        ),
                )
              else
                const SizedBox(),
              IconButton(
                onPressed: openDemarcationBottomSheet,
                icon: const Icon(Icons.menu),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PDF(
              fitPolicy: FitPolicy.BOTH,
              autoSpacing: false,
              pageSnap: false,
              onPageChanged: (int? current, int? total) {
                currentPage = current! + 1;
                _pageCountController.add('${currentPage + 1} - $total');
              },
              onViewCreated: (PDFViewController pdfViewController) async {
                _pdfViewController.complete(pdfViewController);
                await Future.delayed(
                  const Duration(milliseconds: 50),
                );
                final int current =
                    await pdfViewController.getCurrentPage() ?? 0;
                final int? pageCount = await pdfViewController.getPageCount();

                setState(() {
                  currentPage = current + 1;
                  maxPage = pageCount ?? 0;
                });

                _pageCountController.add('${currentPage + 1} - $maxPage');
              },
            ).cachedFromUrl(
              widget.note.notesURL,
              placeholder: (double progress) => Center(
                child: Text('$progress %'),
              ),
              errorWidget: (dynamic error) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onVerticalDragEnd: (details) {
              openDemarcationBottomSheet();
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 36,
                    width: 120,
                    child: CustomButton(
                      textColor: PreMedColorTheme().neutral500,
                      color: PreMedColorTheme().white,
                      isIconButton: true,
                      iconSize: 15,
                      icon: Icons.arrow_back_ios,
                      buttonText: 'Previous',
                      fontSize: 16,
                      onPressed: () {
                        _pdfViewController.future.then((controller) {
                          final int pageNumber = currentPage - 2;

                          if (pageNumber >= 0 && pageNumber < maxPage) {
                            controller.setPage(pageNumber);
                          }
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: PreMedColorTheme().neutral200),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(
                            "$currentPage",
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: PreMedColorTheme().neutral100,
                          border: Border(
                            top: BorderSide(
                              color: PreMedColorTheme().neutral200,
                            ),
                            right: BorderSide(
                              color: PreMedColorTheme().neutral200,
                            ),
                            bottom: BorderSide(
                              color: PreMedColorTheme().neutral200,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(
                            maxPage.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                    width: 120,
                    child: CustomButton(
                      textColor: PreMedColorTheme().white,
                      color: PreMedColorTheme().primaryColorRed,
                      isIconButton: true,
                      leftIcon: false,
                      iconSize: 15,
                      icon: Icons.arrow_forward_ios,
                      buttonText: 'Next',
                      fontSize: 16,
                      onPressed: () {
                        _pdfViewController.future.then((controller) {
                          final int pageNumber = currentPage;

                          if (pageNumber > 0 && pageNumber <= maxPage) {
                            controller.setPage(pageNumber);
                          }
                        });
                      },
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
