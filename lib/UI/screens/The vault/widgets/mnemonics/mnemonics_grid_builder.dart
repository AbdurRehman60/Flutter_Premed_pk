import 'package:premedpk_mobile_app/models/mnemonics_model.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import '../../../../../providers/vaultProviders/mnemonics_provider.dart';
import 'mnemonics_player.dart';
import 'mnemonics_video_card.dart';

class MnemonicsGridBuilder extends StatefulWidget {
  const MnemonicsGridBuilder({super.key});

  @override
  MnemonicsGridBuilderState createState() => MnemonicsGridBuilderState();
}

class MnemonicsGridBuilderState extends State<MnemonicsGridBuilder> {
  String _selectedFilter = 'All';

  void _handleFilterChange(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  List<MnemonicsModel> _filterMnemonics(List<MnemonicsModel> mnemonicsList) {
    if (_selectedFilter == 'All') {
      return mnemonicsList;
    } else {
      return mnemonicsList
          .where((mnemonic) => mnemonic.subject == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<MnemonicsProvider>(builder: (context, mnemonicsPro, _) {
        final List<MnemonicsModel> filteredMnemonics =
            _filterMnemonics(mnemonicsPro.mnemonicsList);

        switch (mnemonicsPro.fetchStatus) {
          case FetchStatus.init:
          case FetchStatus.fetching:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case FetchStatus.error:
            return const Text('Error Fetching Mnemonics');
          case FetchStatus.success:
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterButton(
                        label: 'All',
                        isActive: _selectedFilter == 'All',
                        onTap: () => _handleFilterChange('All'),
                      ),
                      FilterButton(
                        label: 'Physics',
                        isActive: _selectedFilter == 'Physics',
                        onTap: () => _handleFilterChange('Physics'),
                      ),
                      FilterButton(
                        label: 'Chemistry',
                        isActive: _selectedFilter == 'Chemistry',
                        onTap: () => _handleFilterChange('Chemistry'),
                      ),
                      FilterButton(
                        label: 'Biology',
                        isActive: _selectedFilter == 'Biology',
                        onTap: () => _handleFilterChange('Biology'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GridView.builder(
                      itemCount: filteredMnemonics.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        return MnemonicsCard(
                          onPlay: () {
                            if (filteredMnemonics[index].videoUrl != null) {
                              _showVideoDialog(
                                context,
                                filteredMnemonics[index].videoUrl!,
                                filteredMnemonics[index],
                              );
                            }
                          },
                          mnemonics: filteredMnemonics[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.5),
          backgroundColor: isActive ? const Color(0xFFEC5863) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0x80FFFFFF),
              width: 3.0,
            ),
          ),
          elevation: 1,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF4E4B66),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

void _showVideoDialog(
    BuildContext context, String videoUrl, MnemonicsModel mnemonicsModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return VideoScreen(
        mnemonicsModel: mnemonicsModel,
      );
    },
  );
}
