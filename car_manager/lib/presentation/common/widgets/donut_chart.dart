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
  final String? totalPrefix;
  final String? totalSuffix;
  final TextStyle? totalTextStyle;

  const DonutChart({
    super.key,
    required this.sections,
    this.radius = 50.0,
    this.fontSize = 16.0,
    this.centerSpaceRadius = 40,
    this.totalPrefix,
    this.totalSuffix,
    this.totalTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double total = sections.fold(
      0,
      (sum, section) => sum + section.value,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // For landscape mode, use a more compact layout
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {},
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius:
                          centerSpaceRadius * 0.8, // Slightly smaller
                      sections: buildSections(),
                    ),
                  ),
                ),
                // Indicators area
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...buildIndicators(),
                      const SizedBox(height: 16),
                      if (totalPrefix != null || totalSuffix != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${totalPrefix ?? ''} $total ${totalSuffix ?? ''}',
                            style:
                                totalTextStyle ??
                                GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
