import 'package:de_resto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  backgroundColor: white,
  primaryColor: Colors.black,
  textTheme: TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        height: 1.0,
        color: darkOrange),
    headline2: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        height: 2,
        color: darkOrange),
    headline3: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1,
        color: darkOrange),
    headline4: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1,
        color: darkGray),
    subtitle1: GoogleFonts.poppins(
        fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    subtitle2: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: darkGray),
  ),
);
