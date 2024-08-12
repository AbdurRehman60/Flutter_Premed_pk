import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants/constants_export.dart';

class CustomDropdownbtn extends StatefulWidget {
  CustomDropdownbtn({super.key, required this.onProvinceSelected});
  final Function(String) onProvinceSelected;

  @override
  CustomDropdownbtnState createState() => CustomDropdownbtnState();
}

class CustomDropdownbtnState extends State<CustomDropdownbtn> {
  String selectedValue = 'All';
  final List<String> items = ['Punjab', 'Sindh', 'All'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        height: 35,
        width: 102,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            icon: SvgPicture.asset(
              'assets/images/vault/Vector.svg',
              width: 13,
              height: 13,
            ),
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: PreMedTextTheme().heading1.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
              widget.onProvinceSelected(newValue!);
            },
            alignment: Alignment.centerLeft,
            menuMaxHeight: 200.0, // Adjust the height as needed
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
