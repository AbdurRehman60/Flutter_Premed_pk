import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PhoneDropdown extends StatelessWidget {
  const PhoneDropdown(
      {super.key,
      required this.onPhoneNumberSelected,
      required this.hintText,
      this.initialValue});
  final void Function(PhoneNumber) onPhoneNumberSelected;
  final String hintText;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(18),
      child: IntlPhoneField(
        initialValue: initialValue ?? "",
        initialCountryCode: 'PK',
        dropdownTextStyle: PreMedTextTheme().small,
        pickerDialogStyle: PickerDialogStyle(
          countryCodeStyle: PreMedTextTheme().small,
          countryNameStyle: PreMedTextTheme().subtext,
          listTileDivider: Divider(
            thickness: 1,
            color: PreMedColorTheme().neutral300,
          ),
        ),
        dropdownIconPosition: IconPosition.trailing,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: PreMedColorTheme().white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: PreMedColorTheme().neutral900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          hintStyle: PreMedTextTheme().subtext,
        ),
        onChanged: onPhoneNumberSelected,
      ),
    );
  }
}
