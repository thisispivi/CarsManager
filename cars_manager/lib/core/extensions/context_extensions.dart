import 'package:cars_manager/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

extension CarsManagerContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get materialColors => theme.colorScheme;

  AppColorScheme get colors => theme.extension<AppColorScheme>()!;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}
