import 'package:web/web.dart' as web;
import 'package:flutter/services.dart' show rootBundle;

class CarStorage {
  static const String _assetPath = 'assets/data/cars.json';
  static const String _storageKey = 'cars_manager.cars_json';

  static Future<String> loadOrCreateJson() async {
    final stored = web.window.localStorage.getItem(_storageKey);
    if (stored != null && stored.trim().isNotEmpty) return stored;

    final assetJson = await rootBundle.loadString(_assetPath);
    web.window.localStorage.setItem(_storageKey, assetJson);
    return assetJson;
  }

  static Future<void> saveJson(String jsonString) async {
    web.window.localStorage.setItem(_storageKey, jsonString);
  }
}
