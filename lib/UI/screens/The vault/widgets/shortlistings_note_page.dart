//shortListings
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topical%20guides/toical%20guide%20reel%20view.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/shortListing_providers.dart';
import 'guideorNotesReelCard.dart';

class ShortListingNotesPage extends StatelessWidget {
  const ShortListingNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShortListingsProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchNotess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(right: 13),
              child: DummyNotesCard(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          return GuidesOrNotesDisplay(
            notesCategory: 'ShortListings',
            notes: provider.vaultNotesList,
            isLoading: provider.vaultnotesLoadingstatus == Status.fetching,
          );
        }
      },
    );
  }
}
