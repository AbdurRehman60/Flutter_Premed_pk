import 'package:intl_phone_field/countries.dart';

String getCountryName(String countryCode) {
  for (Country country in countries) {
    if (country.dialCode == countryCode) {
      return country.nameTranslations["en"] ?? country.name;
    }
  }

  return "Unknown Country";
}
