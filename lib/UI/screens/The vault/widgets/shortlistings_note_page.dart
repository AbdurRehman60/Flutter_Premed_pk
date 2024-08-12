//shortListings
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/topical%20guides/toical%20guide%20reel%20view.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/shortListing_providers.dart';

class ShortListingNotesPage extends StatelessWidget {
  const ShortListingNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShortListingsProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.fetchNotess(),
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
              notesCategory: 'ShortListings',
              notes: provider.vaultNotesList,
              isLoading: provider.vaultnotesLoadingstatus == Status.fetching,
            ),
          );
        }
      },
    );
  }
}
