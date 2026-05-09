import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'preferences_service.dart';

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
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
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
}
