import 'dart:math' as math;

import 'package:flutter/material.dart';

class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.values,
    required this.color,
    this.strokeWidth = 2,
  });

  final List<double> values;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: values.isEmpty
          ? 'No trend data'
          : 'Trend from ${values.first.toStringAsFixed(0)} to ${values.last.toStringAsFixed(0)}',
      child: CustomPaint(
        painter: _SparklinePainter(
          values: values,
          color: color,
          strokeWidth: strokeWidth,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({
    required this.values,
    required this.color,
    required this.strokeWidth,
  });

  final List<double> values;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.isEmpty) return;

    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final range = math.max(1, maxValue - minValue);
    final step = size.width / (values.length - 1);
    final path = Path();

    for (var i = 0; i < values.length; i++) {
      final x = i * step;
      final normalized = (values[i] - minValue) / range;
      final y = size.height - (normalized * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
