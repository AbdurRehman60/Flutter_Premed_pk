import '../../../../constants/constants_export.dart';

class TestBottomSheet extends StatefulWidget {
  const TestBottomSheet({
    super.key,
    required this.questionNumber,
    required this.timerWidget,
    required this.submitNow,
    required this.reportNow,
    required this.pauseOrContinue,
    required this.restart,
    required this.showButton,
    required this.addFlasCards,
    required this.continueLater,
  });
  final String questionNumber;
  final Widget timerWidget;
  final VoidCallback submitNow;
  final VoidCallback reportNow;
  final VoidCallback restart;
  final VoidCallback pauseOrContinue;
  final bool showButton;
  final VoidCallback addFlasCards;
  final VoidCallback continueLater;

  @override
  State<TestBottomSheet> createState() => _TestBottomSheetState();
}

class _TestBottomSheetState extends State<TestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    widget.questionNumber,
                    style: PreMedTextTheme().body.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxes.vertical2Px,
                  Text(
                    'ATTEMPTED',
                    style: PreMedTextTheme().body.copyWith(
                        color: Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              if (widget.showButton) widget.timerWidget,
            ],
          ),
          SizedBoxes.verticalBig,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 40,
                    offset: Offset(0, 20),
                  )
                ]),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                leading: Image.asset(
                  PremedAssets.Flashcards,
                  height: 50,
                  width: 50,
                ),
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Add to ',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 20,
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: 'My Saved Facts',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 20,
                          color: PreMedColorTheme().red,
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
                ),
                subtitle: Column(
                  children: [
                    SizedBoxes.vertical5Px,
                    Text(
                        'Add current question to flashcards for reviewing later.',
                        style: PreMedTextTheme().body.copyWith(
                              fontSize: 12,
                              color: PreMedColorTheme().black,
                            )),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.addFlasCards();
                },
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
              ),
            ),
          ),
          // SizedBoxes.verticalBig,
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: Colors.white,
          //       boxShadow: const [
          //         BoxShadow(
          //           color: Color(0x26000000),
          //           blurRadius: 40,
          //           offset: Offset(0, 20),
          //         )
          //       ]),
          //   child: Card(
          //     margin: EdgeInsets.zero,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12)),
          //     child: ListTile(
          //       tileColor: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12)),
          //       leading: Image.asset(
          //         PremedAssets.DoubtSolution,
          //         height: 50,
          //         width: 50,
          //       ),
          //       title: RichText(
          //         text: TextSpan(children: [
          //           TextSpan(
          //             text: 'Doubt',
          //             style: PreMedTextTheme().body.copyWith(
          //                 fontSize: 20,
          //                 color: PreMedColorTheme().red,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //           TextSpan(
          //             text: ' Solve',
          //             style: PreMedTextTheme().body.copyWith(
          //                 fontSize: 20,
          //                 color: PreMedColorTheme().black,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ]),
          //       ),
          //       subtitle: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBoxes.vertical5Px,
          //           Text(
          //               'If you don’t understand a particular concept, you can submit a doubt.',
          //               style: PreMedTextTheme().body.copyWith(
          //                     fontSize: 12,
          //                     color: PreMedColorTheme().black,
          //                   )),
          //           SizedBoxes.vertical5Px,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Text(
          //                 'Note This feature requires coins.',
          //                 textAlign: TextAlign.end,
          //                 style: PreMedTextTheme().body.copyWith(
          //                       fontSize: 7,
          //                       color: PreMedColorTheme().black,
          //                     ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //       onTap: () {
          //         Navigator.pop(context);
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (_) => const ExpertSolutionHome()));
          //       },
          //       contentPadding: const EdgeInsets.symmetric(
          //         vertical: 8.0,
          //         horizontal: 16.0,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBoxes.verticalBig,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 40,
                    offset: Offset(0, 20),
                  )
                ]),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                leading: Image.asset(
                  PremedAssets.Alert,
                  height: 50,
                  width: 50,
                ),
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Report',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 20,
                          color: PreMedColorTheme().red,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: ' Issue',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 20,
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxes.vertical5Px,
                    Text(
                        'If you don’t understand a particular concept, you can submit a doubt.',
                        style: PreMedTextTheme().body.copyWith(
                              fontSize: 12,
                              color: PreMedColorTheme().black,
                            )),
                    SizedBoxes.vertical5Px,
                  ],
                ),
                onTap: widget.reportNow,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
              ),
            ),
          ),
          SizedBoxes.verticalBig,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: widget.submitNow,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: PreMedColorTheme().blue),
                    child: Text(
                      'Submit Now',
                      style: PreMedTextTheme().body.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (widget.showButton) SizedBoxes.vertical10Px,
          if (widget.showButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: widget.pauseOrContinue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: PreMedColorTheme().red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Pause/Resume',
                      style: PreMedTextTheme().body.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          SizedBoxes.vertical10Px,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 42,
                child: ElevatedButton(
                  onPressed: widget.continueLater,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: PreMedColorTheme().greenL,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Continue Later',
                    style: PreMedTextTheme().body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: widget.restart,
            child: Text(
              'Restart',
              style: PreMedTextTheme().body.copyWith(
                    fontSize: 17,
                    color: PreMedColorTheme().red,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
