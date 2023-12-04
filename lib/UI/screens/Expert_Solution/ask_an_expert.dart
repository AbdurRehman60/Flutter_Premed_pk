import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/ask_an_expert_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class AskanExpert extends StatelessWidget {
  const AskanExpert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black, // Customize as needed
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white, // Customize as needed
        centerTitle: true,
        title: const Text(
          'Ask an Expert',
          style: TextStyle(
            fontSize: 18, // Adjust as needed
            color: Colors.black, // Customize as needed
          ),
        ),
      ),
      body: AskanExpertForm(),
    );
  }
}
