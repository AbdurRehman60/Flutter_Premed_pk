import 'package:premedpk_mobile_app/UI/screens/expert_solution/data/es_dropdown_data.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';

class CustomResourceDropDown extends StatefulWidget {
  const CustomResourceDropDown({super.key});

  @override
  State<CustomResourceDropDown> createState() => _CustomResourceDropdownState();
}

class _CustomResourceDropdownState extends State<CustomResourceDropDown> {
  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Resource',
            style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBoxes.verticalTiny,
        CustomDropDown(
          hintText: 'Select Resource',
          value: askAnExpertProvider.selectedResource.isEmpty
              ? null
              : askAnExpertProvider.selectedResource,
          options: resourceItems
              .map((String value) =>
                  CustomDropDownOption(value: value, displayOption: value))
              .toList(),
          onChanged: (resource) {
            askAnExpertProvider.selectedResource = resource.toString();
            askAnExpertProvider.selectedSubject = '';
            askAnExpertProvider.selectedTopic = '';
          },
          validator: (value) => validateIsNotEmpty(value, "Resource"),
        ),
        SizedBoxes.verticalBig,
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Subject',
            style: TextStyle(
              fontSize: 16,
    fontWeight: FontWeight.bold,
            )
          ),
        ),
        SizedBoxes.verticalTiny,
        CustomDropDown(
          hintText: 'Select Subject',
          value: askAnExpertProvider.selectedSubject.isEmpty
              ? null
              : askAnExpertProvider.selectedSubject,
          options: subjectList
              .map((String value) =>
                  CustomDropDownOption(value: value, displayOption: value))
              .toList(),
          onChanged: (subject) {
            askAnExpertProvider.selectedSubject = subject.toString();
            askAnExpertProvider.selectedTopic = '';
          },
          validator: (value) => validateIsNotEmpty(value, "Subject"),
        ),
        SizedBoxes.verticalBig,
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Topic',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBoxes.verticalTiny,
        CustomDropDown(
          hintText: 'Select Topic',
          value: askAnExpertProvider.selectedTopic.isEmpty
              ? null
              : askAnExpertProvider.selectedTopic,
          options: getTopicsForResourceAndSubject(
                  askAnExpertProvider.selectedResource,
                  askAnExpertProvider.selectedSubject)
              .map((String value) =>
                  CustomDropDownOption(value: value, displayOption: value))
              .toList(),
          onChanged: (topic) {
            askAnExpertProvider.selectedTopic = topic.toString();
          },
          validator: (value) => validateIsNotEmpty(value, "Topic"),
        ),
      ],
    );
  }

  String? validateOption(String? value) {
    if (value == null) {
      return 'Please choose an option.';
    }
    return null;
  }
}
