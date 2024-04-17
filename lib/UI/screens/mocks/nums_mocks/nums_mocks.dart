import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/mdcat_mocks_provider.dart';
import 'package:provider/provider.dart';

class MocksHome extends StatefulWidget {
  const MocksHome({super.key});

  @override
  State<MocksHome> createState() => _MocksHomeState();
}

class _MocksHomeState extends State<MocksHome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MocksProvider>(context, listen: false).fetchDeckGroups();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'NUMS Mocks',
                      style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!',
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: PreMedColorTheme().black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<MocksProvider>(
              builder: (context, mocksProvider, _) {
                switch (mocksProvider.fetchStatus) {
                  case FetchStatus.init:
                  case FetchStatus.fetching:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case FetchStatus.success:
                    return ListView.builder(
                      itemCount: mocksProvider.deckGroups.length,
                      itemBuilder: (context, index) {
                        final deckGroup = mocksProvider.deckGroups[index];
                        return Container(
                          height: 110,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(deckGroup.deckGroupImage ?? 'https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/Logos/logo512.png'),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(deckGroup.deckGroupName, style: PreMedTextTheme().heading3.copyWith(fontWeight: FontWeight.w800, fontSize: 20),),
                                  SizedBoxes.vertical2Px,
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${deckGroup.deckNameCount} ',
                                          style: PreMedTextTheme().heading5.copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text: 'Papers',
                                          style: PreMedTextTheme().heading5.copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded, color: PreMedColorTheme().primaryColorRed),
                                onPressed: () {
                                },
                              ),
                              onTap: () {},
                            ),
                          ),

                        );
                      },
                    );
                  case FetchStatus.error:
                    return const Center(
                      child: Text('Error fetching deck groups'),
                    );
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}
