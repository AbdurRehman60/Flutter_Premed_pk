import 'package:flutter/material.dart';

const List<String> bioTopicsAKU = [
  "Introductory Biology - AKU",
  "Kingdoms - AKU",
  "Organ Systems 1 (Class 11) - AKU",
  "Organ Systems 2 (Class 12) - AKU",
  "Genetics and Evolution - AKU",
  "Environmental Biology - AKU",
];

const List<String> chemTopicsAKU = [
  "Introductory Chemistry - AKU",
  "Physical Chemistry - AKU",
  "Inorganic Chemistry - AKU",
  "Organic Chemistry - AKU",
  "Applications of Chemistry - AKU",
];

const List<String> physTopicsAKU = [
  "Introductory Physics - AKU",
  "Periodic Movement and Waves - AKU",
  "Physics of Electricity - AKU",
  "Atomic and Modern Physics - AKU",
];

const List<String> mathsTopicsAKU = ["Mathematics Reasoning - AKU"];

const List<String> sciReasTopicsAKU = ["Science Reasoning - AKU"];

const List<String> bioTopicsNUMS = [
  "Bioenergetics - NUMS",
  "Biological Molecules - NUMS",
  "Cell Structure and Function - NUMS",
  "Coordination and Control - NUMS",
  "Enzymes - NUMS",
  "Evolution - NUMS",
  "Gaseous Exchange - NUMS",
  "Kingdom Prokaryote - NUMS",
  "Nutrition - NUMS",
  "Reproduction - NUMS",
  "Transport - NUMS",
  "Variation and Genetics - NUMS",
  "Support and Movement - NUMS",
];

const List<String> chemTopicsNUMS = [
  "Introduction to Fundamental Concepts of Chemistry - NUMS",
  "Alcohols, Phenols and Ethers - NUMS",
  "Aldehydes and Ketones - NUMS",
  "Atomic Structure - NUMS",
  "Carboxylic Acids and its Derivatives - NUMS",
  "Chemical Bonding - NUMS",
  "Chemical Equilibrium - NUMS",
  "Fundamental Principles of Organic Chemistry - NUMS",
  "Hydrocarbons - NUMS",
  "s and p Block Elements - NUMS",
  "Thermochemistry - NUMS",
  "States of Matter - Gases, Liquids and Solids - NUMS",
  "Reaction Kinetics - NUMS",
];

const List<String> physTopicsNUMS = [
  "Circular motion and Momentum - NUMS",
  "Current Electricity - NUMS",
  "Electrochemistry - NUMS",
  "Electronics - NUMS",
  "Electrostatics - NUMS",
  "Forces and Motion - NUMS",
  "Heat and Thermodynamics - NUMS",
  "Wave Motion and Sound - NUMS",
  "Work, Power and Energy - NUMS",
  "Magnetism and Electromagnetic Induction - NUMS",
  "Nuclear Physics - NUMS",
];

const List<String> engTopicsNUMS = [
  "Fill in the blank - NUMS",
  "Grammar and Punctuation - NUMS",
  "Identify Errors in Sentence - NUMS",
  "Key Vocabulary - NUMS",
  "Passage - NUMS",
  "Tenses and Sentence Structure - NUMS",
];

const List<String> lrTopicsNUMS = [
  "Critical Thinking",
  "Letters and Symbols Series",
  "Logical Deduction",
  "Logical Problems",
  "Course of Action",
  "Cause and Effect",
];

const List<String> bioTopicsMDCAT = [
  "Biological Molecules",
  "Enzymes",
  "Cell Structure and Function",
  "Bio-diversity | Variety of Life",
  "Variety of Life",
  "Kingdom Prokaryote",
  "Kingdom Protista",
  "Kingdom Fungi",
  "Kingdom Plantae",
  "Kingdom Animalia",
  "Bioenergetics",
  "Nutrition",
  "Gaseous Exchange",
  "Transport",
  "Homeostasis",
  "Support and Movement",
  "Coordination and Control",
  "Reproduction",
  " Growth and Development",
  "Chromosomes and DNA",
  "Cell Cycle",
  "Variation and Genetics",
  "Biotechnology",
  "Evolution",
  "Man and His Environment",

  // Add more topics as needed
];

const List<String> chemTopicsMDCAT = [
  "Introduction to Fundamental Concepts of Chemistry",
  "Experimental Techniques in Chemistry",
  "Stoichiometry",
  "States of Matter - Gases, Liquids and Solids",
  "Atomic Structure",
  "Chemical Bonding",
  "Thermochemistry",
  "Chemical Equilibrium",
  "Solution and Colloids",
  "Electrochemistry",
  "Acids, Bases and Salts",
  "Reaction Kinetics",
  "Periodicity in Elements",
  "s and p Block Elements",
  "d and f Block Elements",
  "Fundamental Principles of Organic Chemistry",
  "Hydrocarbons",
  "Alkyl Halides and Amines",
  "Alcohols, Phenols and Ethers",
  "Aldehydes and Ketones",
  "Carboxylic Acids and its Derivatives",
  "Chemistry of Life",
  "Industrial Chemistry",
  "Analytical Chemistry",
  "Environmental Chemistry",
  "Macromolecules",

  // Add more topics as needed
];

const List<String> physTopicsMDCAT = [
  "Measurements",
  "Scalars and Vectors",
  "Forces and Motion",
  "Motion in Two Dimensions",
  "Work, Power and Energy",
  "Circular Motion and Momentum",
  "Gravitation",
  "Fluid Dynamics",
  "Oscillations and Simple Harmonic Motion",
  "Wave Motion and Sound",
  "Optics, Nature of Light and Optical Instruments",
  "Heat and Thermodynamics",
  "Electrostatics",
  "Current Electricity",
  "Magnetism and Electromagnetic Induction",
  "Electromagnetic Waves",
  "Alternating Current",
  "Electromagnetic Waves and Electronics",
  "Physics of Solids",
  "Electronics",
  "Dawn of Modern Physics",
  "Atomic Spectra",
  "Nuclear Physics",

  // Add more topics as needed
];

const List<String> engTopicsMDCAT = [
  "Key Vocabulary",
  "Tenses and Sentence Structure",
  "Grammar and Punctuation",
  "Fill in the blank",
  "Identify errors in sentence",
  "Passage",

  // Add more topics as needed
];

const List<String> lrTopicsMDCAT = [
  "Critical Thinking",
  "Letters and Symbols Series",
  "Logical Deduction",
  "Logical Problems",
  "Course of Action",
  "Cause and Effect",
];

const List<String> others = ["Others"];

class CustomResourceDropDown extends StatefulWidget {
  @override
  _CustomResourceDropdownState createState() => _CustomResourceDropdownState();
}

class _CustomResourceDropdownState extends State<CustomResourceDropDown> {
  String selectedResource = 'AKU Past Papers';
  String selectedSubject = 'Biology';
  String selectedTopic = 'Select a Topic';

  List<String> subjectList = [
    'Biology',
    'Chemistry',
    'Physics',
    'Mathematics',
    'Logical Reasoning',
    'English',
  ];

  Map<String, List<String>> topicsMap = {
    'Biology': bioTopicsAKU,
    'Chemistry': chemTopicsAKU,
    'Physics': physTopicsAKU,
    'Mathematics': mathsTopicsAKU,
    'Logical Reasoning': sciReasTopicsAKU,
  };

  List<String> getTopicsForResourceAndSubject(String resource, String subject) {
    if (resource == 'AKU Past Papers') {
      if (subject == 'Mathematics') {
        return mathsTopicsAKU;
      } else if (subject == 'Physics') {
        return physTopicsAKU;
      } else if (subject == 'Chemistry') {
        return chemTopicsAKU;
      } else if (subject == 'Biology') {
        return bioTopicsAKU;
      } else if (subject == 'Logical Reasoning') {
        return sciReasTopicsAKU;
      }
    } else if (resource == 'MDCAT Past Papers') {
      if (subject == 'Physics') {
        return physTopicsMDCAT;
      } else if (subject == 'Chemistry') {
        return chemTopicsMDCAT;
      } else if (subject == 'Biology') {
        return bioTopicsMDCAT;
      } else if (subject == 'English') {
        return engTopicsMDCAT;
      } else if (subject == 'Logical Reasoning') {
        return lrTopicsMDCAT;
      }
    } else if (resource == 'NUMS Past Papers') {
      if (subject == 'Physics') {
        return physTopicsNUMS;
      } else if (subject == 'Chemistry') {
        return chemTopicsNUMS;
      } else if (subject == 'Biology') {
        return bioTopicsNUMS;
      } else if (subject == 'English') {
        return engTopicsNUMS;
      } else if (subject == 'Logical Reasoning') {
        return lrTopicsNUMS;
      }
    }
    return others;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Select Resource',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                // Wrap DropdownButton in a SingleChildScrollView
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: selectedResource,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedResource = newValue!;
                      selectedSubject = 'Biology'; // Reset subject
                      selectedTopic = 'Select a Topic'; // Reset topic
                    });
                  },
                  items: <String>[
                    'AKU Past Papers',
                    'MDCAT Past Papers',
                    'NUMS Past Papers'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'What subject is the question related to?',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            // Wrap DropdownButton in a SingleChildScrollView
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: selectedSubject,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSubject = newValue!;
                  selectedTopic = 'Select a Topic'; // Reset topic
                });
              },
              items: subjectList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Select Topic',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            // Wrap DropdownButton in a SingleChildScrollView
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: selectedTopic,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTopic = newValue!;
                });
              },
              items: <String>[
                'Select a Topic',
                ...getTopicsForResourceAndSubject(
                    selectedResource, selectedSubject)
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}
