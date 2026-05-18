import 'package:cars_manager/core/services/preferences_service.dart';
import 'package:cars_manager/models/car.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Coordinates local notification setup and due-date reminder scheduling.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  /// Returns the shared notification service instance.
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes timezone data and platform notification settings.
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

  /// Schedules reminder notifications for a single due date.
  ///
  /// Android exact alarms are attempted first for timely reminders. If the
  /// platform denies exact alarms, the notification is retried as inexact so
  /// scheduling never crashes the app.
  Future<void> scheduleDueDateNotification({
    required int id,
    required String carName,
    required String itemName, // e.g., 'insurance'
    required DateTime dueDate,
    required PreferencesService prefs,
  }) async {
    if (!prefs.notificationsEnabled) return;
    final hasPermission = await requestNotificationPermission();
    if (!hasPermission) return;

    for (int days in prefs.reminderIntervals) {
      final scheduleDate = dueDate.subtract(Duration(days: days));
      if (scheduleDate.isBefore(DateTime.now())) continue;

      final notificationId = '${id}_$days'.hashCode;
      final daysText = days == 0 ? 'today' : 'in $days days';
      final title = 'Upcoming Due Date';
      final body = 'Your $carName\'s $itemName expires $daysText';

      final scheduledDate = tz.TZDateTime.from(scheduleDate, tz.local);
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'due_dates',
          'Due Dates',
          channelDescription: 'Reminders for car maintenance and renewals',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      );

      try {
        await _notificationsPlugin.zonedSchedule(
          id: notificationId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      } on PlatformException catch (error) {
        if (error.code != 'exact_alarms_not_permitted') rethrow;
        await _notificationsPlugin.zonedSchedule(
          id: notificationId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexact,
        );
      }
    }
  }

  /// Cancels all reminder notifications associated with an item id.
  Future<void> cancelItemNotifications(
    int baseId,
    PreferencesService prefs,
  ) async {
    for (int days in [90, 30, 7, 3, 1, 0]) {
      final notificationId = '${baseId}_$days'.hashCode;
      await _notificationsPlugin.cancel(id: notificationId);
    }
  }

  /// Schedules reminders for every due-date type currently tracked by [car].
  Future<void> scheduleCarReminders({
    required Car car,
    required PreferencesService prefs,
  }) async {
    final insuranceDate = car.nextInsuranceExpirationDate;
    if (insuranceDate != null) {
      await cancelItemNotifications(Object.hash(car.id, 'insurance'), prefs);
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
      await cancelItemNotifications(Object.hash(car.id, 'inspection'), prefs);
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
      await cancelItemNotifications(Object.hash(car.id, 'tax'), prefs);
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
  Future<bool> showTestNotification() async {
    final hasPermission = await requestNotificationPermission();
    if (!hasPermission) return false;

    await _notificationsPlugin.show(
      id: 0,
      title: 'Cars Manager',
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
    return true;
  }

  /// Schedules a near-future reminder through the same Android scheduling
  /// mechanism used by real due-date reminders.
  Future<bool> scheduleTestReminder({
    Duration delay = const Duration(minutes: 2),
  }) async {
    final hasPermission = await requestNotificationPermission();
    if (!hasPermission) return false;

    final scheduledDate = tz.TZDateTime.from(
      DateTime.now().add(delay),
      tz.local,
    );
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'due_dates',
        'Due Dates',
        channelDescription: 'Reminders for car maintenance and renewals',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: 'Cars Manager reminder',
        body: 'Scheduled reminders are working.',
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } on PlatformException catch (error) {
      if (error.code != 'exact_alarms_not_permitted') rethrow;
      await _notificationsPlugin.zonedSchedule(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: 'Cars Manager reminder',
        body: 'Scheduled reminders are working.',
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexact,
      );
    }

    return true;
  }

  /// Requests the platform notification permission when required.
  Future<bool> requestNotificationPermission() async {
    final android = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      final enabled = await android.areNotificationsEnabled();
      if (enabled == true) return true;
      return await android.requestNotificationsPermission() ?? false;
    }

    final ios = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return true;
  }
}
