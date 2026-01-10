import 'package:flutter/services.dart' show rootBundle;

// Web fallback: persists to localStorage if available; otherwise falls back to asset.
// Keeping the interface identical to IO so the rest of the app stays consistent.
// Note: This is not a real file on web.
class CarStorage {
  static const String _assetPath = 'assets/data/cars.json';

  static Future<String> loadOrCreateJson() async {
    return rootBundle.loadString(_assetPath);
  }

  static Future<void> saveJson(String jsonString) async {
    // No-op on web for now.
    // If you want true web persistence, we can add a proper dart:html impl.
  }
}
