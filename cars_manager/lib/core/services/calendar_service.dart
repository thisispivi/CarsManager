import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:cars_manager/core/services/calendar_url_launcher_stub.dart'
    if (dart.library.js_interop) 'package:cars_manager/core/services/calendar_url_launcher_web.dart';

enum CalendarAddResult { nativeCalendar, browserCalendar }

class CalendarService {
  static const MethodChannel _channel = MethodChannel('cars_manager/calendar');

  static Future<CalendarAddResult> addEvent({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    bool allDay = true,
    String? description,
    String? location,
  }) async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final opened = await _openAndroidCalendar(
        title: title,
        startDate: startDate,
        endDate: endDate,
        allDay: allDay,
        description: description,
        location: location,
      );
      if (opened) return CalendarAddResult.nativeCalendar;
    }

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final opened = await Add2Calendar.addEvent2Cal(
        Event(
          title: title,
          description: description,
          location: location,
          startDate: startDate,
          endDate: endDate,
          allDay: allDay,
        ),
      );
      if (opened) return CalendarAddResult.nativeCalendar;
    }

    await _openGoogleCalendar(
      title: title,
      startDate: startDate,
      endDate: endDate,
      allDay: allDay,
      description: description,
      location: location,
    );
    return CalendarAddResult.browserCalendar;
  }

  static Future<bool> _openAndroidCalendar({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required bool allDay,
    String? description,
    String? location,
  }) async {
    try {
      return await _channel.invokeMethod<bool>('addEvent', {
            'title': title,
            'description': description,
            'location': location,
            'startDate': startDate.millisecondsSinceEpoch,
            'endDate': endDate.millisecondsSinceEpoch,
            'allDay': allDay,
          }) ??
          false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  static Future<void> _openGoogleCalendar({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required bool allDay,
    String? description,
    String? location,
  }) async {
    final dates = allDay
        ? '${_googleDay(startDate)}/${_googleDay(endDate)}'
        : '${_googleDateTime(startDate)}/${_googleDateTime(endDate)}';
    final uri = Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': title,
      'dates': dates,
      if (description != null && description.isNotEmpty) 'details': description,
      if (location != null && location.isNotEmpty) 'location': location,
    });

    final launched = await openCalendarUrl(uri);
    if (!launched) {
      throw PlatformException(
        code: 'calendar_launch_failed',
        message: 'Could not open calendar.',
      );
    }
  }

  static String _googleDay(DateTime date) =>
      DateFormat('yyyyMMdd').format(date);

  static String _googleDateTime(DateTime date) =>
      DateFormat("yyyyMMdd'T'HHmmss'Z'").format(date.toUtc());
}
