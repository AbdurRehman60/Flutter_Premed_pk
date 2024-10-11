import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/dashboard_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/Test Interface/widgets/pie_chart.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../providers/update_attempt_provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({
    super.key,
    required this.attemptId,
    required this.correct,
    required this.incorrect,
    required this.skipped,
  });

  final String attemptId;
  final int correct;
  final int incorrect;
  final int skipped;

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final attemptProvider = Provider.of<AttemptProvider>(context, listen: false);
      attemptProvider.getAttemptInfo(widget.attemptId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: PreMedColorTheme().background,
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 5,
                  offset: Offset(1, 7),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: Provider.of<PreMedProvider>(context, listen: false).isPreMed
                      ? PreMedColorTheme().red
                      : PreMedColorTheme().blue),
              onPressed: () {
                navigateToHomeScreen(context);
              },
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analytics',
                style: PreMedTextTheme().heading6.copyWith(
                    color: PreMedColorTheme().black, fontWeight: FontWeight.bold),
              ),
              SizedBoxes.vertical2Px,
              Text('TEST RESULT',
                  style: PreMedTextTheme().subtext.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: PreMedColorTheme().black,
                  ))
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Consumer<AttemptProvider>(
        builder: (context, attemptProvider, child) {
          if (attemptProvider.status == AStatus.fetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (attemptProvider.status == AStatus.success) {
            final attemptInfo = attemptProvider.attemptInfo;
            final resultMeta = attemptProvider.resultMeta;  // Access resultMeta

            // Ensure resultMeta is not null
            return resultMeta != null
                ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resultMeta.deckName, // Access deckName from resultMeta
                      style: PreMedTextTheme()
                          .body
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w800),
                    ),
                    SizedBoxes.verticalLarge,

                    AttemptPieChart(
                      correct: widget.correct,
                      incorrect: widget.incorrect,
                      skipped: widget.skipped,
                    ),
                    SizedBoxes.verticalGargangua,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 187,
                              decoration: BoxDecoration(
                                boxShadow: CustomBoxShadow.boxShadow40,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.85),
                              ),
                              margin: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.PieChart),
                                      SizedBoxes.verticalMedium,
                                      Text(
                                        'Total Marks Scored: ${resultMeta.totalMarks}', // Access totalMarks from resultMeta
                                        textAlign: TextAlign.center,
                                        style: PreMedTextTheme()
                                            .body
                                            .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBoxes.horizontalTiny,
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 187,
                              decoration: BoxDecoration(
                                boxShadow: CustomBoxShadow.boxShadow40,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.85),
                              ),
                              margin: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.Timer),
                                      SizedBoxes.verticalMedium,
                                      Text(
                                        'Total Time Taken: ${resultMeta.totalTimeTaken}s', // Access totalTimeTaken from resultMeta
                                        textAlign: TextAlign.center,
                                        style: PreMedTextTheme()
                                            .body
                                            .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBoxes.horizontalTiny,
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 187,
                              decoration: BoxDecoration(
                                boxShadow: CustomBoxShadow.boxShadow40,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.85),
                              ),
                              margin: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.Graph),
                                      SizedBoxes.verticalMedium,
                                      Text(
                                        'Avg Time Per Question: ${resultMeta.avgTimeTaken.toStringAsFixed(2)}s', // Access avgTimeTaken from resultMeta
                                        textAlign: TextAlign.center,
                                        style: PreMedTextTheme()
                                            .body
                                            .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalBig,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: CustomBoxShadow.boxShadow40,
                        color: Colors.white.withOpacity(0.85),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text('Summary',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                            SizedBoxes.verticalGargangua,
                            _buildInfoRow('Attempted:', resultMeta.attempted.toString()),  // Access attempted from resultMeta
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Average Time Taken',
                                    style: PreMedTextTheme()
                                        .body
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  '${resultMeta.avgTimeTaken.toStringAsFixed(2)}s', // Access avgTimeTaken directly from resultMeta
                                  textAlign: TextAlign.center,
                                  style: PreMedTextTheme()
                                      .body
                                      .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            _buildInfoRow('Negatives Due to Wrong:', resultMeta.negativesDueToWrong.toString()),
                            _buildInfoRow('No of Negatively Marked:', resultMeta.noOfNegativelyMarked.toString()),
                            _buildInfoRow('Total Marks:', resultMeta.totalMarks.toString()),
                            _buildInfoRow('Total Questions:', resultMeta.totalQuestions.toString()),
                            _buildInfoRow('Total Time Taken:', '${resultMeta.totalTimeTaken}s'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : const Center(child: Text('No attempt info available'));
          } else {
            return Center(child: Text(attemptProvider.message));
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const MainNavigationScreen(),
        ),
      ),
    );
  }
}
