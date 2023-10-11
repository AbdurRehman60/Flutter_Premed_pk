import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CityDropdownList extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String) onChanged;

  CityDropdownList({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      getImmediateSuggestions: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Search for a city',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
      suggestionsCallback: (pattern) {
        return items.where(
            (item) => item.toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData),
        );
      },
      onSuggestionSelected: (itemData) {
        onChanged(itemData);
      },
      noItemsFoundBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('No cities found.'),
        );
      },
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: true,
    );
  }
}
