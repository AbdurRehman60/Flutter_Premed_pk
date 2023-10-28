String? validateIsNotEmpty(String? value, String title) {
  if (value == null || value.isEmpty) {
    return '$title cannot not be empty.';
  }
  return null;
}

String? validateSelectOption(String? value, String title) {
  if (value == null) {
    return 'Please choose an $title.';
  }
  return null;
}
