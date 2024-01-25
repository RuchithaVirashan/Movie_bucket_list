import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.lato().fontFamily,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
    ),
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF154478),
      primary: const Color(0xFF154478),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xD1EAEAEA),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(width: 1, color: Color(0xFFF4F4F4)),
      ),
    ),
  );
}
