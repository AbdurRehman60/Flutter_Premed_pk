import '../../../../constants/constants_export.dart';

Widget buildError({String? message}) {
  return Center(
    child: Text(message ?? 'Error fetching data'),
  );
}
