// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class Country {
//   final String name;
//   final String code;

//   Country(this.name, this.code);
// }

// List<Country> getCountries() {
//   final List<Country> countries = [];
//   final locales = NumberFormat().compactSimpleCurrencySymbols.keys;

//   for (var locale in locales) {
//     if (locale != null) {
//       final country = Country(
//         Intl.displayCountryCode(locale, locale),
//         locale,
//       );
//       countries.add(country);
//     }
//   }

//   return countries;
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Country Code Dropdown Example'),
//         ),
//         body: Center(
//           child: CountryCodeSelector(),
//         ),
//       ),
//     );
//   }
// }

// class CountryCodeSelector extends StatefulWidget {
//   @override
//   _CountryCodeSelectorState createState() => _CountryCodeSelectorState();
// }

// class _CountryCodeSelectorState extends State<CountryCodeSelector> {
//   String? selectedCountryCode;

//   @override
//   void initState() {
//     super.initState();
//     selectedCountryCode = getCountries()[0].code; // Set an initial value
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Selected Country Code: +$selectedCountryCode',
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(height: 20.0),
//           CountryCodeDropdown(
//             selectedCountryCode: selectedCountryCode,
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedCountryCode = newValue;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CountryCodeDropdown extends StatefulWidget {
//   final String? selectedCountryCode;
//   final ValueChanged<String?> onChanged;

//   CountryCodeDropdown({
//     required this.selectedCountryCode,
//     required this.onChanged,
//   });

//   @override
//   _CountryCodeDropdownState createState() => _CountryCodeDropdownState();
// }

// class _CountryCodeDropdownState extends State<CountryCodeDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         DropdownButton<String>(
//           value: widget.selectedCountryCode,
//           onChanged: widget.onChanged,
//           items: getCountries().map((Country country) {
//             return DropdownMenuItem<String>(
//               value: country.code,
//               child: Text('${country.name} (+${country.code})'),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
