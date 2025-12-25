import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ================= BACKGROUND =================
  static const Color background = Color(0xFFF6F7FB);

  // ================= SURFACE / CARD =================
  static const Color surface = Color(0xFFFFFFFF);

  // ================= TEXT =================
  static const Color primaryText = Color(0xFF1C1C1E);
  static const Color secondaryText = Color(0xFF8E8E93);

  // ================= BRAND COLORS =================
  static const Color primary = Color(0xFF7C7CFF); // Purple
  static const Color accent = Color(0xFFFF7AC6); // Pink

  // ================= ICON =================
  static const Color icon = Color(0xFF1C1C1E);

  // ================= GRADIENT =================
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF6F7FB),
      Colors.black,
    ],
  );
}
