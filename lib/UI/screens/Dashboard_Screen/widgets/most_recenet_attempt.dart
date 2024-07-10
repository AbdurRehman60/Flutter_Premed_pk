import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/recent_activity_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/lastest_attempts_provider.dart';
import 'package:provider/provider.dart';

class LatestAttemptScreen extends StatelessWidget {
  const LatestAttemptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<LatestAttemptPro>(context, listen: false)
          .fetchLatestAttempt('64c68bc9f093d0bd25c026de'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching latest attempts'),
          );
        } else {
          return Consumer<LatestAttemptPro>(
            builder: (context, latestAttemptProvider, _) {
              switch (latestAttemptProvider.status) {
                case FetchAttemptStatus.init:
                case FetchAttemptStatus.fetching:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case FetchAttemptStatus.success:
                  final latestAttempt = latestAttemptProvider.latestAttempt;
                  if (latestAttempt != null &&
                      latestAttempt.results.isNotEmpty) {
                    return RecentActivityCard(
                      acivityname: latestAttempt.results.first.deckName,
                      date: latestAttempt.results.first.createdAt,
                      progressValue: latestAttempt.results.first.totalAttempts /
                          latestAttempt.results.first.totalQuestions,
                      mode: latestAttempt.results.first.attemptMode,
                    );
                  } else {
                    return const Center(
                      child: Text('No attempts available'),
                    );
                  }
                case FetchAttemptStatus.error:
                  return const Center(
                    child: Text('Error fetching latest attempts'),
                  );
              }
            },
          );
        }
      },
    );
  }
}
