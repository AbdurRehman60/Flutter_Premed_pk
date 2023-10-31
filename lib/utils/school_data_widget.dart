import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:premedpk_mobile_app/export.dart';

class SchoolDropdownList extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String) onChanged;

  SchoolDropdownList({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      getImmediateSuggestions: true,
      textFieldConfiguration: const TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Enter your School',
          border: OutlineInputBorder(),
          // prefixIcon: Icon(Icons.search),
        ),
      ),
      suggestionsCallback: (pattern) {
        return items.where(
            (item) => item.toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(
            itemData,
            style: PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().white),
          ),
        );
      },
      onSuggestionSelected: (itemData) {
        onChanged(itemData);
      },
      noItemsFoundBuilder: (context) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No schools found.'),
        );
      },
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: true,
    );
  }
}
