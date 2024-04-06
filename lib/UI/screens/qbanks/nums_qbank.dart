// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/qbank_tile.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/sub_bank_tile.dart';
// import 'package:premedpk_mobile_app/providers/nums_qbank_proivder.dart';
// import 'package:provider/provider.dart';
// import '../../../constants/constants_export.dart';
// import '../../../models/deck_model.dart';
// import '../../../providers/decks_provider.dart';
// import '../mdcat_qb/mdcat_yearly_papers/federal_mdcat_papers.dart';
//
// class NumsQbank extends StatefulWidget {
//   const NumsQbank({Key? key}) : super(key: key);
//
//   @override
//   State<NumsQbank> createState() => _NumsQbankState();
// }
//
// class _NumsQbankState extends State<NumsQbank> {
//   @override
//   Widget build(BuildContext context) {
//     final deckPro = Provider.of<DecksProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 deckPro.getTopicalDecks();
//               },
//               icon: Icon(Icons.ac_unit)),
//           IconButton(
//               onPressed: () {
//                 deckPro.getYearlyDecks();
//               },
//               icon: Icon(Icons.add))
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             children: [
//               // ButtonRow(
//               //   onTopicalTap: () {
//               //     setState(() {
//               //       deckPro.changeDecktype();
//               //     });
//               //   },
//               //   onYearlyTap: () {
//               //     setState(() {
//               //       deckPro.changeDecktype();
//               //     });
//               //   }, ontap: () {  },
//               // ),
//               Expanded(
//                 child: FutureBuilder<Map<String, dynamic>>(
//                   future: Provider.of<DecksProvider>(context, listen: false)
//                       .fetchDecks('NUMS QBank'),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return _buildLoading(); // Show loading indicator
//                     } else if (snapshot.hasError) {
//                       return _buildError(); // Show error message
//                     } else {
//                       final Map<String, dynamic>? data = snapshot.data;
//                       if (data != null && data['status'] == true) {
//                         // Data loaded successfully
//                         return _buildDecksList(Provider.of<DecksProvider>(
//                           context,
//                         ).deckList);
//                       } else {
//                         // Data loading failed
//                         return _buildError(message: data?['message']);
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoading() {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//
//   Widget _buildDecksList(List<DeckModel> deckList) {
//     return ListView.builder(
//       itemCount: deckList.length,
//       itemBuilder: (context, index) {
//         final deck = deckList[index];
//         return QbankTile(
//           qbank: deck,
//           onTap: () {
//             showModalBottomSheet(
//                 context: context,
//                 builder: (context) => Container(
//                       child: ListView.builder(
//                           itemCount: deckList[index].subDeckDetails.length,
//                           itemBuilder: (context, index) => SubBankTile(
//                               onTap: () {},
//                               details: deck.subDeckDetails[index])),
//                     ));
//             // Handle tap event if needed
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildError({String? message}) {
//     return Center(
//       child: Text(message ?? 'Error fetching data'),
//     );
//   }
// }
