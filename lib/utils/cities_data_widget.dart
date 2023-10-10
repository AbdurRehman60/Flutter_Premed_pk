import 'package:flutter/material.dart';
// Import the school data
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';

class CityDropdownList extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  const CityDropdownList({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedItem,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
