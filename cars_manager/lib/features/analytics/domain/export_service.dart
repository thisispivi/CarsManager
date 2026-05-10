import 'dart:io';

import 'package:cars_manager/models/car.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart' show Share, XFile;

class ExportService {
  static String carsToCSV(List<Car> cars) {
    final buffer = StringBuffer();
    buffer.writeln('Car,Type,Date,Amount,Notes');

    for (final car in cars) {
      for (final e in car.fuel) {
        final date = DateFormat('yyyy-MM-dd').format(e.date);
        buffer.writeln(
          '${_escape(car.name)},Fuel,$date,${e.totalCost.toStringAsFixed(2)},${e.fuelType.name}',
        );
      }
      for (final e in car.insuranceDatas) {
        final date = DateFormat('yyyy-MM-dd').format(e.startDate);
        buffer.writeln(
          '${_escape(car.name)},Insurance,$date,${e.premiumAmount.toStringAsFixed(2)},${_escape(e.policyNumber)}',
        );
      }
      for (final e in car.inspectionDatas) {
        final date = DateFormat('yyyy-MM-dd').format(e.date);
        final amount = e.amount?.toStringAsFixed(2) ?? '0.00';
        buffer.writeln('${_escape(car.name)},Inspection,$date,$amount,');
      }
      for (final e in car.taxDatas) {
        final date = DateFormat('yyyy-MM-dd').format(e.date);
        buffer.writeln(
          '${_escape(car.name)},Tax,$date,${e.amount.toStringAsFixed(2)},',
        );
      }
      for (final e in car.repairDatas) {
        final date = DateFormat('yyyy-MM-dd').format(e.date);
        buffer.writeln(
          '${_escape(car.name)},Repair,$date,${e.amount.toStringAsFixed(2)},${_escape(e.description)}',
        );
      }
      for (final e in car.fineDatas) {
        final date = DateFormat('yyyy-MM-dd').format(e.date);
        buffer.writeln(
          '${_escape(car.name)},Fine,$date,${e.amount.toStringAsFixed(2)},${e.type.name}',
        );
      }
    }

    return buffer.toString();
  }

  static Future<void> shareCSV(String csv, String filename) async {
    if (kIsWeb) {
      await Share.share(csv, subject: filename);
      return;
    }

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsString(csv);
    await Share.shareXFiles([
      XFile(file.path, mimeType: 'text/csv'),
    ], subject: filename);
  }

  static String _escape(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
