import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF0B7A4B);
  static const Color primaryDark = Colors.black;
  static const Color gray = Color(0xFF929292);
  static const Color fieldBg = Color(0xFFF7F7F7);
  static const Color borderColor = Color(0xFFE6E6E6);
  static const Color dividerColor = Color(0xFFE6E6E6);


  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'NotoSans',
    );
  }
}
