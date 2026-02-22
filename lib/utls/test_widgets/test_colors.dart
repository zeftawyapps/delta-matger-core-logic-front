import 'package:flutter/material.dart';

class TestColors {
  // Primary colors
  static const Color primary = Color.fromARGB(255, 194, 195, 243);
  static const Color primaryLight = Color(0xFFA5B4FC);

  // Background colors
  static const Color scaffoldBg = Color(0xFF0A0C14);
  static const Color sidebarBg = Color(0xFF0F111A);
  static const Color surface = Color(0xFF151926);
  static const Color cardBg = Color(0xFF151926);
  static const Color terminalBg = Colors.black;
  static const Color codeBg = Color(0xFF0D1117);

  // Text & Icon colors (active/inactive)
  static const Color textAcent = Color(0xFFA5B4FC);
  static const Color logText = Color.fromARGB(255, 157, 168, 225);
  static const Color inactiveIcon = Colors.white54;
  static const Color inactiveText = Colors.white54;
  static const Color subtleText = Colors.white24;
  static const Color divider = Colors.white10;

  // Opacity variations for standard colors
  static Color primaryWithOpacity(double opacity) =>
      primary.withOpacity(opacity);
  static Color surfaceWithOpacity(double opacity) =>
      Colors.white.withOpacity(opacity);
}
