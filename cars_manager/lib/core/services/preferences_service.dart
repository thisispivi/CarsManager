import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class PreferencesService extends ChangeNotifier {
  static final PreferencesService _instance = PreferencesService._internal();

  factory PreferencesService() => _instance;
  PreferencesService._internal();

  static const String _notificationsEnabledKey = 'notificationsEnabled';
  static const String _intervalsKey = 'notificationIntervals';

  bool _notificationsEnabled = true;
  List<int> _reminderIntervals = [90, 30, 7, 1];

  bool get notificationsEnabled => _notificationsEnabled;
  List<int> get reminderIntervals => _reminderIntervals;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool(_notificationsEnabledKey) ?? true;
    final storedIntervals = prefs.getStringList(_intervalsKey);
    if (storedIntervals != null) {
      _reminderIntervals = storedIntervals.map((e) => int.parse(e)).toList();
    }
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, value);
    notifyListeners();
  }

  Future<void> updateIntervals(List<int> intervals) async {
    _reminderIntervals = intervals;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _intervalsKey,
      intervals.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }
}
