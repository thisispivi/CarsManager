import 'package:web/web.dart' as web;

Future<bool> openCalendarUrl(Uri uri) async {
  return web.window.open(uri.toString(), '_blank') != null;
}
