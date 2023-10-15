import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoei/utils/hex_color.dart';

final kTitleColor = hexColor('#020202');
final kDateColor = hexColor('#111111');
final kCompletedColor = hexColor('#35D388');
final kInactiveColor = hexColor('#B8B8B8');
final kTextColor = hexColor('#050505');
final kBackgroundColor = hexColor("#FBFBFB");

class TodoTheme {
  static TextTheme todoTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      fontSize: 24,
      letterSpacing: 0,
      color: kTitleColor,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: GoogleFonts.montserrat(
      fontSize: 24,
      letterSpacing: 0,
      color: kDateColor,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 20,
      letterSpacing: 0,
      fontWeight: FontWeight.bold,
      color: kTextColor,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      color: kInactiveColor,
    ),
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 0,
      color: kTextColor,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      letterSpacing: 0,
      color: kInactiveColor,
      fontWeight: FontWeight.w600,
    ),
  );

  static ThemeData todoThemeData = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      background: kBackgroundColor,
    ),
    textTheme: todoTextTheme,
    hintColor: kInactiveColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kCompletedColor,
      titleTextStyle: todoTextTheme.titleLarge!.copyWith(
        color: kBackgroundColor,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kCompletedColor,
      elevation: 0,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateColor.resolveWith(
        (states) => kCompletedColor,
      ),
      fillColor: MaterialStateColor.resolveWith(
        (states) => kBackgroundColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: kInactiveColor),
      ),
    ),
  );
}
