import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../providers/vaultProviders/cheatsheets_provider.dart';
import '../topical guides/toical guide reel view.dart';

class CheatSheetsReel extends StatefulWidget {
  const CheatSheetsReel({super.key});

  @override
  _CheatSheetsReelState createState() => _CheatSheetsReelState();
}

class _CheatSheetsReelState extends State<CheatSheetsReel> {
  late Future<void> _fetchCheatSheetsFuture;

  @override
  void initState() {
    super.initState();
    _fetchCheatSheetsFuture = Future.microtask(() async {
      final provider = context.read<CheatsheetsProvider>();
      await provider.fetchNotess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CheatsheetsProvider,PreMedAccessProvider>(
      builder: (context, cheatSheetsProvider,preMedAccessPro, child) {
        return FutureBuilder<void>(
          future: _fetchCheatSheetsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: PreMedColorTheme().red,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return GuidesOrNotesDisplay(
                hasAccess: preMedAccessPro.hasCheatsheets,
                notes: cheatSheetsProvider.vaultNotesList,
                isLoading: cheatSheetsProvider.vaultnotesLoadingstatus == CheatSheetsFetchStatus.fetching,
                notesCategory: 'Cheat Sheets',
              );
            }
          },
        );
      },
    );
  }
}
