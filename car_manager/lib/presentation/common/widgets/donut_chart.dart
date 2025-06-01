import 'package:car_manager/presentation/common/widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartSection {
  final Color color;
  final double value;
  final String title;
  final Color textColor;
  final String label;

  const PieChartSection({
    required this.color,
    required this.value,
    required this.title,
    required this.textColor,
    required this.label,
  });
}

class DonutChart extends StatelessWidget {
  final List<PieChartSection> sections;
  final double radius;
  final double fontSize;
  final double centerSpaceRadius;

  const DonutChart({
    super.key,
    required this.sections,
    this.radius = 50.0,
    this.fontSize = 16.0,
    this.centerSpaceRadius = 40,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.75,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: centerSpaceRadius,
                sections: buildSections(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildIndicators(),
          ),
        ],
      ),
    );
  }

  List<Widget> buildIndicators() {
    final List<Widget> indicators = [];

    for (var section in sections) {
      indicators.add(
        Indicator(color: section.color, text: section.label, isSquare: false),
      );

      if (section != sections.last) {
        indicators.add(const SizedBox(height: 4));
      }
    }

    return indicators;
  }

  List<PieChartSectionData> buildSections() {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return sections.map((section) {
      return PieChartSectionData(
        color: section.color,
        value: section.value,
        title: section.title,
        radius: radius,
        titleStyle: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: section.textColor,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
