import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;

  void toggleTheme() => isDark.value = !isDark.value;

  // ================= BACKGROUND GRADIENT =================
  LinearGradient get backgroundGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark.value
            ? const [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ]
            : const [
                Color(0xFFFAD0C4),
                Color(0xFFFF9A9E),
              ],
      );

  // ================= SCAFFOLD =================
  Color get scaffoldColor =>
      isDark.value ? const Color(0xFF0E0F13) : const Color(0xFFF6F7FB);

  // ================= CARD =================
  Color get cardColor =>
      isDark.value ? const Color(0xFF1A1B20) : Colors.white;

  // ================= TEXT =================
  Color get primaryText =>
      isDark.value ? Colors.white : const Color(0xFF1C1C1E);

  Color get secondaryText =>
      isDark.value ? const Color(0xFFA1A1AA) : const Color(0xFF8E8E93);

  // ================= APP BAR =================
  Color get appBarIcon =>
      isDark.value ? Colors.white : const Color(0xFF1C1C1E);

  Color get appBarText =>
      isDark.value ? Colors.white : const Color(0xFF1C1C1E);

  // ================= ACCENT =================
  Color get accent =>
      isDark.value ? const Color(0xFF7C7CFF) : const Color(0xFF9B6BFF);

  // ================= ICON =================
  Color get icon =>
      isDark.value ? Colors.white : const Color(0xFF1C1C1E);
}
