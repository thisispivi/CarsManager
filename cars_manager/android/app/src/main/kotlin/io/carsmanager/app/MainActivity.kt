package io.carsmanager.app

import android.content.ActivityNotFoundException
import android.content.Intent
import android.provider.CalendarContract
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val calendarChannel = "cars_manager/calendar"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, calendarChannel).setMethodCallHandler { call, result ->
            if (call.method != "addEvent") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val title = call.argument<String>("title")
            val startDate = call.argument<Long>("startDate")
            val endDate = call.argument<Long>("endDate")
            if (title == null || startDate == null || endDate == null) {
                result.error("invalid_args", "Missing calendar event data.", null)
                return@setMethodCallHandler
            }

            val intent = Intent(Intent.ACTION_INSERT).apply {
                data = CalendarContract.Events.CONTENT_URI
                putExtra(CalendarContract.Events.TITLE, title)
                putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startDate)
                putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endDate)
                putExtra(CalendarContract.EXTRA_EVENT_ALL_DAY, call.argument<Boolean>("allDay") ?: true)
                call.argument<String>("description")?.let {
                    putExtra(CalendarContract.Events.DESCRIPTION, it)
                }
                call.argument<String>("location")?.let {
                    putExtra(CalendarContract.Events.EVENT_LOCATION, it)
                }
            }

            try {
                startActivity(intent)
                result.success(true)
            } catch (_: ActivityNotFoundException) {
                result.success(false)
            } catch (error: Exception) {
                result.error("calendar_launch_failed", error.message, null)
            }
        }
    }
}
