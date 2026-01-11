import 'package:flutter/material.dart';

Color dueDateColorForDays(int daysRemaining) {
  if (daysRemaining < 0) return Colors.grey;
  if (daysRemaining < 7) return Colors.red;
  if (daysRemaining < 30) return Colors.orange;
  return Colors.green;
}
