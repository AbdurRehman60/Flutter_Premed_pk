import 'package:premedpk_mobile_app/UI/screens/Test Interface/widgets/pie_chart.dart';
import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
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
void navigateToHomeScreen(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: HomeScreen(),
      ),
    ),
  );
}
class _AnalyticsState extends State<Analytics> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final attemptProvider =
      Provider.of<AttemptProvider>(context, listen: false);
      attemptProvider.getAttemptInfo(widget.attemptId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
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
                    color: PreMedColorTheme().black,
                    fontWeight: FontWeight.bold),
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
          if (attemptProvider.status == Status.fetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (attemptProvider.status == Status.success) {
            final attemptInfo = attemptProvider.attemptInfo;
            return attemptInfo != null
                ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attemptInfo['deckName'],
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 28, fontWeight: FontWeight.w800),
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
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                margin: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.PieChart),
                                      SizedBoxes.verticalMedium,
                                      Text('Total Marks Scored: ${attemptInfo['totalMarks']}s', style: PreMedTextTheme().body.copyWith(fontWeight: FontWeight.w600, fontSize: 17),),
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
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                margin: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.Timer),
                                      SizedBoxes.verticalMedium,
                                      Text('Total Time Taken: ${attemptInfo['totalTimeTaken']}s',style: PreMedTextTheme().body.copyWith(fontWeight: FontWeight.w600, fontSize: 17),),
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
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                                margin: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(PremedAssets.Graph),
                                      SizedBoxes.verticalMedium,
                                      Text('Avg Time Per Question: ${attemptInfo['avgTimeTaken']}s',style: PreMedTextTheme().body.copyWith(fontWeight: FontWeight.w600, fontSize: 17),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalGargangua,
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                              _buildInfoRow('Attempted:',
                                  attemptInfo['attempted'].toString()),
                              _buildInfoRow('Average Time Taken:', '${attemptInfo['avgTimeTaken']}s'),
                              _buildInfoRow(
                                  'Negatives Due to Wrong:',
                                  attemptInfo['negativesDueToWrong']
                                      .toString()),
                              _buildInfoRow(
                                  'No of Negatively Marked:',
                                  attemptInfo['noOfNegativelyMarked']
                                      .toString()),
                              _buildInfoRow('Total Marks:',
                                  attemptInfo['totalMarks'].toString()),
                              _buildInfoRow(
                                  'Total Questions:',
                                  attemptInfo['totalQuestions']
                                      .toString()),
                              _buildInfoRow('Total Time Taken:',
                                  '${attemptInfo['totalTimeTaken']}s'),
                            ],
                          ),
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
      )
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
}
