import 'package:cars_manager/core/services/preferences_service.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notificationsPlugin.initialize(settings: initSettings);
  }

  Future<void> scheduleDueDateNotification({
    required int id,
    required String carName,
    required String itemName, // e.g., 'insurance'
    required DateTime dueDate,
    required PreferencesService prefs,
  }) async {
    if (!prefs.notificationsEnabled) return;

    for (int days in prefs.reminderIntervals) {
      final scheduleDate = dueDate.subtract(Duration(days: days));
      if (scheduleDate.isBefore(DateTime.now())) continue;

      final notificationId = '${id}_$days'.hashCode;
      final daysText = days == 0 ? 'today' : 'in $days days';
      final title = 'Upcoming Due Date';
      final body = 'Your $carName\'s $itemName expires $daysText';

      await _notificationsPlugin.zonedSchedule(
        id: notificationId,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduleDate, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'due_dates',
            'Due Dates',
            channelDescription: 'Reminders for car maintenance and renewals',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  Future<void> cancelItemNotifications(
    int baseId,
    PreferencesService prefs,
  ) async {
    for (int days in [30, 7, 3, 0]) {
      // Or stored max intervals
      final notificationId = '${baseId}_$days'.hashCode;
      await _notificationsPlugin.cancel(id: notificationId);
    }
  }

  Future<void> scheduleCarReminders({
    required Car car,
    required PreferencesService prefs,
  }) async {
    final insuranceDate = car.nextInsuranceExpirationDate;
    if (insuranceDate != null) {
      await scheduleDueDateNotification(
        id: Object.hash(car.id, 'insurance'),
        carName: car.name,
        itemName: 'insurance',
        dueDate: insuranceDate,
        prefs: prefs,
      );
    }

    final inspectionDate = car.nextInspectionDate;
    if (inspectionDate != null) {
      await scheduleDueDateNotification(
        id: Object.hash(car.id, 'inspection'),
        carName: car.name,
        itemName: 'inspection',
        dueDate: inspectionDate,
        prefs: prefs,
      );
    }

    final taxDate = car.nextTaxDueDate;
    if (taxDate != null) {
      await scheduleDueDateNotification(
        id: Object.hash(car.id, 'tax'),
        carName: car.name,
        itemName: 'tax',
        dueDate: taxDate,
        prefs: prefs,
      );
    }
  }

  /// Fires an immediate notification so the user can preview how reminders
  /// look on their device without waiting for a real due date.
  Future<void> showTestNotification() async {
    await _notificationsPlugin.show(
      id: 0,
      title: 'CarsManager',
      body: 'Notifications are working! Your reminders will appear here.',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'due_dates',
          'Due Dates',
          channelDescription: 'Reminders for car maintenance and renewals',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
