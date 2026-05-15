import 'package:flutter/widgets.dart';

enum ScreenSize { compact, medium, expanded, large, extraLarge }

extension ScreenSizeX on ScreenSize {
  bool get isCompact => this == ScreenSize.compact;

  bool get isRail => this == ScreenSize.medium || this == ScreenSize.expanded;

  bool get isDesktop =>
      this == ScreenSize.large || this == ScreenSize.extraLarge;

  double get pageMargin => switch (this) {
    ScreenSize.compact => 16,
    ScreenSize.medium => 24,
    ScreenSize.expanded => 32,
    ScreenSize.large => 48,
    ScreenSize.extraLarge => 64,
  };

  double get contentMaxWidth => switch (this) {
    ScreenSize.extraLarge => 1400,
    ScreenSize.large => 1200,
    _ => double.infinity,
  };
}

ScreenSize screenSizeForWidth(double width) {
  if (width >= 1600) return ScreenSize.extraLarge;
  if (width >= 1200) return ScreenSize.large;
  if (width >= 900) return ScreenSize.expanded;
  if (width >= 600) return ScreenSize.medium;
  return ScreenSize.compact;
}

ScreenSize screenSizeOf(BuildContext context) {
  return screenSizeForWidth(MediaQuery.sizeOf(context).width);
}
