import 'package:cars_manager/app/app.dart';
import 'package:cars_manager/core/services/notification_service.dart';
import 'package:cars_manager/data/cars_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCarData();
  await NotificationService().init();
  runApp(const ProviderScope(child: CarsManagerApp()));
}
