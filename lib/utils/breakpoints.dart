import 'package:flutter/material.dart';

class Breakpoints {
  static Size _size(BuildContext context) => MediaQuery.sizeOf(context);

  static bool isTablet(BuildContext context) => _size(context).width >= 768;

  static bool isDesktop(BuildContext context) => _size(context).width >= 1100;

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 56;
    if (isTablet(context)) return 32;
    return 20;
  }

  static double verticalSpacing(BuildContext context) =>
      isTablet(context) ? 24 : 16;

  static int gridColumns(BuildContext context, {int mobile = 2}) {
    final width = _size(context).width;
    if (width >= 1300) return 4;
    if (width >= 900) return 3;
    return mobile;
  }

  static double cardHeight(BuildContext context) =>
      isDesktop(context) ? 340 : (isTablet(context) ? 300 : 260);
}

