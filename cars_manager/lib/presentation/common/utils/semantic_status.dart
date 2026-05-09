import 'package:flutter/material.dart';

enum SemanticStatus { valid, dueSoon, overdue }

extension SemanticStatusExtension on SemanticStatus {
  Color get color {
    switch (this) {
      case SemanticStatus.valid:
        return Colors.green;
      case SemanticStatus.dueSoon:
        return Colors.orange;
      case SemanticStatus.overdue:
        return Colors.red;
    }
  }

  String get label {
    switch (this) {
      case SemanticStatus.valid:
        return 'Valid';
      case SemanticStatus.dueSoon:
        return 'Due soon';
      case SemanticStatus.overdue:
        return 'Overdue';
    }
  }
}

class DueDateState {
  final int daysRemaining;
  final SemanticStatus status;
  final Color color;

  DueDateState({
    required this.daysRemaining,
    required this.status,
    required this.color,
  });

  factory DueDateState.fromDate(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final daysRemaining = due.difference(today).inDays;

    final SemanticStatus status;
    if (daysRemaining < 0) {
      status = SemanticStatus.overdue;
    } else if (daysRemaining <= 30) {
      status = SemanticStatus.dueSoon;
    } else {
      status = SemanticStatus.valid;
    }

    return DueDateState(
      daysRemaining: daysRemaining,
      status: status,
      color: status.color,
    );
  }
}
