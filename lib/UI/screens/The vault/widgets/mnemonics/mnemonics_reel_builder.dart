import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/mnemonics/mnemonics_card.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/mnemonics/mnemonics_player.dart';
import 'package:premedpk_mobile_app/models/mnemonics_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';

import '../../../../../providers/vaultProviders/mnemonics_provider.dart';

class MnemonicsReelBuilder extends StatefulWidget {
  const MnemonicsReelBuilder({super.key});

  @override
  State<MnemonicsReelBuilder> createState() => _MnemonicsReelBuilderState();
}

class _MnemonicsReelBuilderState extends State<MnemonicsReelBuilder> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MnemonicsProvider>(context, listen: false).getMnemonics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MnemonicsProvider, PreMedAccessProvider>(
      builder: (context, mnemonicsProvider, preMedAccesPro, _) {
        switch (mnemonicsProvider.fetchStatus) {
          case FetchStatus.init:
          case FetchStatus.fetching:
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),
            );

          case FetchStatus.success:
            return Container(
              height: 119,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 20),
                  blurRadius: 40,
                ),
              ]),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mnemonicsProvider.mnemonicsList.length,
                itemBuilder: (context, index) {
                  final MnemonicsModel mnemonic =
                      mnemonicsProvider.mnemonicsList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: MnemonicsBuilderCard(
                      hasAccess: preMedAccesPro.hasMnemonics,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              mnemonicsModels: mnemonicsProvider
                                  .mnemonicsList,
                              initialIndex:
                                  index,
                            ),
                          ),
                        );
                      },
                      mnemonicsModel: mnemonic,
                    ),
                  );
                },
              ),
            );

          case FetchStatus.error:
            return const Center(
              child: Text('Error fetching mnemonics'),
            );
        }
      },
    );
  }
}
