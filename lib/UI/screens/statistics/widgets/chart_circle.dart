import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartCircle extends StatelessWidget {
  const ChartCircle({
    super.key,
    required this.subjects,
    required this.percentages,
  });
  final List<String> subjects;
  final List<String> percentages;

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sections = [];

    for (int i = 0; i < subjects.length; i++) {
      sections.add(
        PieChartSectionData(
          title: '',
          radius: 17,
          value: double.parse(percentages[i]),
          color: _getSubjectColor(subjects[i]),
        ),
      );
    }

    return PieChart(
      PieChartData(
        centerSpaceRadius: 30,
        sectionsSpace: 0.0,
        sections: sections,
      ),
    );
  }

  Color _getSubjectColor(String subject) {
    switch (subject) {
      case 'Biology':
        return const Color(0xFF42C96B);
      case 'Physics':
        return const Color(0xFF0383BB);
      case 'Chemistry':
        return const Color(0xFFC40052);
      case 'Logical Reasoning':
        return const Color(0xFF8800C3);
      case 'English':
        return const Color(0xFFFB9666);
      default:
        return Colors.black;
    }
  }
}
