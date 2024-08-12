import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/essential_stuff_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import 'essential_stuff_card.dart';

class EssenceStuffBuilder extends StatefulWidget {
  const EssenceStuffBuilder({super.key});

  @override
  State<EssenceStuffBuilder> createState() => _EssenceStuffBuilderState();
}

class _EssenceStuffBuilderState extends State<EssenceStuffBuilder> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<EssentialStuffProvider>(context, listen: false)
          .getEssentialStuff();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EssentialStuffProvider>(
        builder: (context, essencestuffpro, _) {
      switch (essencestuffpro.fetchStatus) {
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
            height: 85,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff26000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: essencestuffpro.essentialStuffList.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: EssenStuffCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EstuffPdfView(
                                        categoryName: 'Essential Stuff',
                                        essenceStuffModel: essencestuffpro
                                            .essentialStuffList[index])));
                          },
                          essenStuffModel:
                              essencestuffpro.essentialStuffList[index]),
                    )),
          );
        case FetchStatus.error:
          return const Center(
            child: Text('Error Fetching Data'),
          );
      }
    });
  }
}
