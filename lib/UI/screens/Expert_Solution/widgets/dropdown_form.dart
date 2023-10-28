import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/data/es_data.dart';
import 'package:premedpk_mobile_app/UI/widgets/custom_dropdown.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/repository/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';

class CustomResourceDropDown extends StatefulWidget {
  @override
  _CustomResourceDropdownState createState() => _CustomResourceDropdownState();
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
            'Select Resource',
            style: TextStyle(
              fontSize: 16, // Adjust as needed
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
            'Select Subject',
            style: TextStyle(
              fontSize: 16, // Adjust as needed
            ),
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
            'Select Topic',
            style: TextStyle(
              fontSize: 16, // Adjust as needed
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
  }
}
