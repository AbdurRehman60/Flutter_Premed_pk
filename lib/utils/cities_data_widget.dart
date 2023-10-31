import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:premedpk_mobile_app/export.dart';

class CityDropdownList extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String?) onChanged;

  CityDropdownList({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String?>(
      getImmediateSuggestions: true,
      textFieldConfiguration: const TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Enter your City',
          border: OutlineInputBorder(),
        ),
      ),
      suggestionsCallback: (pattern) {
        return items
            .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, String? itemData) {
        return ListTile(
          title: Text(
            itemData ?? '',
            style: PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().white),
          ),
        );
      },
      onSuggestionSelected: (String? itemData) {
        onChanged(itemData); // Call the provided onChanged callback
      },
      noItemsFoundBuilder: (context) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No cities found.'),
        );
      },
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: true,
    );
  }
}
