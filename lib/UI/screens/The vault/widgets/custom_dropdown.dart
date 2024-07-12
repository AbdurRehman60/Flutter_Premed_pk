import 'package:flutter_svg/svg.dart';

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
  bool isDropdownOpened = false;
  OverlayEntry? floatingDropdown;

  void _toggleDropdown() {
    if (isDropdownOpened) {
      floatingDropdown?.remove();
    } else {
      floatingDropdown = _createFloatingDropdown();
      Overlay.of(context).insert(floatingDropdown!);
    }

    setState(() {
      isDropdownOpened = !isDropdownOpened;
    });
  }

  OverlayEntry _createFloatingDropdown() {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: renderBox.localToGlobal(Offset.zero).dy + size.height,
        left: renderBox.localToGlobal(Offset.zero).dx,
        child: Material(
          elevation: 8.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: items.length * 40.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: items.map((String value) {
                return SizedBox(
                  height: 40,
                  child: ListTile(
                    title: Text(
                      value,
                      style: PreMedTextTheme().heading1.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      setState(() {
                        selectedValue = value;
                      });
                      widget.onProvinceSelected(value);
                      _toggleDropdown();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        height: 35,
        width: 102,
        padding: const EdgeInsets.symmetric(horizontal: 8,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                selectedValue,
                style: PreMedTextTheme().heading1.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SvgPicture.asset(
              'assets/images/vault/Vector.svg',
              width: 13,
              height: 13,
            ),
          ],
        ),
      ),
    );
  }
}
