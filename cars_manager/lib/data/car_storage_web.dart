import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;

class CarStorage {
  static const String _assetPath = 'assets/data/cars.json';
  static const String _storageKey = 'cars_manager.cars_json';

  static Future<String> loadOrCreateJson() async {
    final stored = html.window.localStorage[_storageKey];
    if (stored != null && stored.trim().isNotEmpty) {
      return stored;
    }

    final assetJson = await rootBundle.loadString(_assetPath);
    html.window.localStorage[_storageKey] = assetJson;
    return assetJson;
  }

  static Future<void> saveJson(String jsonString) async {
    html.window.localStorage[_storageKey] = jsonString;
  }
}
