import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CityDropdownList extends StatefulWidget {

  const CityDropdownList({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });
  final List<String> items;
  final String selectedItem;
  final void Function(String?) onChanged;

  @override
  State<CityDropdownList> createState() => _CityDropdownListState();
}

class _CityDropdownListState extends State<CityDropdownList> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _typeAheadController.text = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: TypeAheadField<String?>(
        getImmediateSuggestions: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_city_sharp),
            hintText: 'City',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: PreMedColorTheme().white,
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
          return widget.items
              .where(
                (item) => item.toLowerCase().contains(
              pattern.toLowerCase(),
            ),
          )
              .toList();
        },
        itemBuilder: (context, String? itemData) {
          return ListTile(
            title: Text(
              itemData ?? '',
              style: PreMedTextTheme().subtext,
            ),
          );
        },
        onSuggestionSelected: (String? itemData) {
          setState(() {
            _typeAheadController.text = itemData!;
          });
          widget.onChanged(itemData); // Call the provided onChanged callback
        },
        noItemsFoundBuilder: (context) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No cities found.'),
          );
        },
        hideOnLoading: true,
      ),
    );
  }
}
