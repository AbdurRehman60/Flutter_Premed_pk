import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import '../../../../constants/constants_export.dart';
import '../../../Widgets/global_widgets/empty_state.dart';

class VaultPdfViewer extends StatefulWidget {
  const VaultPdfViewer(
      {super.key, required this.vaultNotesModel, required this.notesCategory});
  final VaultNotesModel vaultNotesModel;
  final String notesCategory;

  @override
  State<VaultPdfViewer> createState() => _VaultPdfViewerState();
}

class _VaultPdfViewerState extends State<VaultPdfViewer> {
  int currentPage = 0;
  int maxPage = 0;
  bool isDownloading = false;
  bool isDownloaded = false;

  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();
  @override
  void dispose() {
    _pageCountController.close();
    super.dispose();
  }

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
                  itemCount: widget.vaultNotesModel.pagination?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();

                        _pdfViewController.future.then(
                          (controller) {
                            final int pageNumber = widget
                                .vaultNotesModel.pagination![index].startPageNo;

                            if (pageNumber >= 0 && pageNumber < maxPage) {
                              controller.setPage(pageNumber - 1);
                            }
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/content.png',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                widget.vaultNotesModel.pagination![index].name,
                                style: PreMedTextTheme().body.copyWith(
                                    fontSize: 16,
                                    fontWeight: currentPage ==
                                            widget.vaultNotesModel
                                                .pagination![index].startPageNo
                                        ? FontWeight.w700
                                        : FontWeight.w700,
                                    color: currentPage ==
                                            widget.vaultNotesModel
                                                .pagination![index].startPageNo
                                        ? PreMedColorTheme().primaryColorRed
                                        : PreMedColorTheme().neutral900),
                              ),
                            ),
                          ],
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

  void _showAlertDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: PreMedTextTheme()
                .body
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(
            title,
            style: PreMedTextTheme().body.copyWith(
                  fontSize: 13,
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _pageCountController.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AppBar(
                centerTitle: false,
                backgroundColor: PreMedColorTheme().white,
                leading: const PopButton(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.vaultNotesModel.topicName,
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
                            child: Text(widget.notesCategory,
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
              ),
            ),
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
              widget.vaultNotesModel.pdfUrl,
              placeholder: (double progress) => Center(
                child: Column(
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
                      child: GestureDetector(
                        onTap: () {
                          if (widget.vaultNotesModel.pagination != null &&
                              widget.vaultNotesModel.pagination!.isNotEmpty) {
                            openDemarcationBottomSheet();
                          } else {
                            _showAlertDialog(
                                context, 'No Demarcations Available');
                          }
                        },
                        child: Image.asset(
                          'assets/images/Menu.png',
                        ),
                      )),
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
                      onTap: () {
                        _showAlertDialog(context, 'Coming Soon');
                      },
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
