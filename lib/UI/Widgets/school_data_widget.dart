import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SchoolDropdownList extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String) onChanged;

  const SchoolDropdownList({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  State<SchoolDropdownList> createState() => _SchoolDropdownListState();
}

class _SchoolDropdownListState extends State<SchoolDropdownList> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _typeAheadController.text = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      getImmediateSuggestions: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _typeAheadController,
        decoration: InputDecoration(
          hintText: 'Enter your School',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: PreMedColorTheme().neutral400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: PreMedColorTheme().neutral900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          hintStyle: PreMedTextTheme().subtext,
        ),
      ),
      suggestionsCallback: (pattern) {
        return widget.items.where(
            (item) => item.toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(
            itemData,
            style: PreMedTextTheme().subtext,
          ),
        );
      },
      onSuggestionSelected: (String itemData) {
        setState(() {
          _typeAheadController.text = itemData;
        });
        widget.onChanged(itemData);
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
