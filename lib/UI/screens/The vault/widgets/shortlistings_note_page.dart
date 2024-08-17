//shortListings
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topical%20guides/toical%20guide%20reel%20view.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/shortListing_providers.dart';

class ShortListingNotesPage extends StatefulWidget {
  const ShortListingNotesPage({super.key});

  @override
  _ShortListingNotesPageState createState() => _ShortListingNotesPageState();
}

class _ShortListingNotesPageState extends State<ShortListingNotesPage> {
  late Future<void> _fetchNotesFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotesFuture = Future.microtask(() async {
      final provider = context.read<ShortListingsProvider>();
      await provider.fetchNotess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ShortListingsProvider, PreMedAccessProvider>(
      builder: (context, shortListingsProvider, premedAccessProvider, child) {
        return FutureBuilder<void>(
          future: _fetchNotesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else {
              return Container(
                height: 83,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 20),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: GuidesOrNotesDisplay(
                  hasAccess: premedAccessProvider.hasShortListings,
                  notesCategory: 'ShortListings',
                  notes: shortListingsProvider.vaultNotesList,
                  isLoading: shortListingsProvider.vaultnotesLoadingstatus == Status.fetching,
                ),
              );
            }
          },
        );
      },
    );
  }
}
