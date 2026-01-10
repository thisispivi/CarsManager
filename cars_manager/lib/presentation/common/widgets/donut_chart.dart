import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

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

class DonutChart extends StatefulWidget {
  final List<PieChartSection> sections;
  final double radius;
  final double fontSize;
  final double centerSpaceRadius;
  final String? totalPrefix;
  final String? totalSuffix;
  final TextStyle? totalTextStyle;
  final Locale locale;

  const DonutChart({
    super.key,
    required this.sections,
    this.radius = 48.0,
    this.fontSize = 16.0,
    this.centerSpaceRadius = 60.0,
    this.totalPrefix,
    this.totalSuffix,
    this.totalTextStyle,
    this.locale = const Locale('en'),
  });

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  late List<bool> _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = List<bool>.filled(widget.sections.length, true);
  }

  @override
  void didUpdateWidget(covariant DonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.sections.length == widget.sections.length) {
      return;
    }

    final next = List<bool>.filled(widget.sections.length, true);
    final common = math.min(_enabled.length, next.length);
    for (var i = 0; i < common; i++) {
      next[i] = _enabled[i];
    }
    _enabled = next;
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern(widget.locale.toString());
    final enabledTotal = widget.sections
        .asMap()
        .entries
        .where((e) => _enabled[e.key])
        .fold<double>(0.0, (sum, e) => sum + e.value.value);

    final String total = numberFormat.format(enabledTotal);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: SizedBox(
                    height: 220,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: widget.centerSpaceRadius * 0.8,
                        sections: _buildSections(enabledTotal),
                        pieTouchData: PieTouchData(enabled: false),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildIndicators(),
                      const SizedBox(height: 8),
                      if (widget.totalPrefix != null ||
                          widget.totalSuffix != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${widget.totalPrefix ?? ''} $total ${widget.totalSuffix ?? ''}',
                            style:
                                widget.totalTextStyle ??
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

  List<Widget> _buildIndicators() {
    final List<Widget> indicators = [];

    for (var i = 0; i < widget.sections.length; i++) {
      final section = widget.sections[i];

      indicators.add(
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() {
              _enabled[i] = !_enabled[i];
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _enabled[i]
                        ? section.color
                        : section.color.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  section.label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _enabled[i]
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.55),
                    decoration: _enabled[i] ? null : TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (section != widget.sections.last) {
        indicators.add(const SizedBox(height: 2));
      }
    }

    return indicators;
  }

  List<PieChartSectionData> _buildSections(double enabledTotal) {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return widget.sections.asMap().entries.map((entry) {
      final idx = entry.key;
      final section = entry.value;
      final enabled = _enabled[idx];
      final value = enabled ? section.value : 0.0;

      String title = '';
      if (enabled && enabledTotal > 0) {
        final perc = (section.value / enabledTotal) * 100;
        title = '${perc.round()}%';
      }

      return PieChartSectionData(
        color: enabled ? section.color : section.color.withValues(alpha: 0.25),
        value: value,
        title: title,
        radius: widget.radius,
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
