

import 'package:provider/provider.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../models/mnemonics_model.dart';
import '../../../../../providers/vaultProviders/mnemonics_provider.dart';
import '../topic_button.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxes.vertical3Px,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Wrap(
                    spacing: 12,
                    children: [
                      TopicButton(
                        topicName: 'All',
                        isActive: _selectedFilter == 'All',
                        onTap: () => _handleFilterChange('All'),
                      ),
                      TopicButton(
                        topicName: 'Physics',
                        isActive: _selectedFilter == 'Physics',
                        onTap: () => _handleFilterChange('Physics'),
                      ),
                      TopicButton(
                        topicName: 'Chemistry',
                        isActive: _selectedFilter == 'Chemistry',
                        onTap: () => _handleFilterChange('Chemistry'),
                      ),
                      TopicButton(
                        topicName: 'Biology',
                        isActive: _selectedFilter == 'Biology',
                        onTap: () => _handleFilterChange('Biology'),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.vertical3Px,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 8),
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
                                index,
                                mnemonicsPro.mnemonicsList,
                              );
                            } else {
                              _showVideoDialog(
                              context,
                              index,
                              mnemonicsPro.mnemonicsList,
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


void _showVideoDialog(
    BuildContext context, int index, List<MnemonicsModel> mnemonicsModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return VideoScreen(
        mnemonicsModels: mnemonicsModel,
        initialIndex: index,
      );
    },
  );
}
