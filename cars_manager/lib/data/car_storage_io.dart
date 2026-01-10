import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class CarStorage {
  static const String _fileName = 'cars.json';
  static const String _assetPath = 'assets/data/cars.json';

  static Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  static Future<String> loadOrCreateJson() async {
    final file = await _localFile();

    if (await file.exists()) {
      return file.readAsString();
    }

    final assetJson = await rootBundle.loadString(_assetPath);
    await file.writeAsString(assetJson);
    return assetJson;
  }

  static Future<void> saveJson(String jsonString) async {
    final file = await _localFile();
    await file.writeAsString(jsonString);
  }
}
