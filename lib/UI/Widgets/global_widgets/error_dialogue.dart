import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

void showError(BuildContext context, Map<String, dynamic> response,
    {bool? navigate}) {
  final bool shouldNavigate = navigate ?? false;

  if (shouldNavigate && Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
  showDialog(
    barrierColor: const Color.fromARGB(110, 0, 0, 0),
    barrierDismissible: false,
    context: context,
    builder: (context) => ErrorDialog(
      errorMessage: response['message'] ?? '',
    ),
  );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({required this.errorMessage, super.key});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(90, 0, 0, 0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                errorMessage,
                style: PreMedTextTheme().body,
                textAlign: TextAlign.center,
              ),
              SizedBoxes.verticalLarge,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                child: CustomButton(
                  color: Provider.of<PreMedProvider>(context,listen: false).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                  buttonText: "Okay",
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
