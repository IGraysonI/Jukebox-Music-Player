import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme applicationTextTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 72,
      fontWeight: FontWeight.w600,
    ),
  ),
  headline2: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 60,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w300,
    ),
  ),
  headline3: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.normal,
    ),
  ),
  headline4: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.normal,
    ),
  ),
  headline5: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 24,
      letterSpacing: -0.18,
      fontWeight: FontWeight.w400,
    ),
  ),
  headline6: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 20,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w400,
    ),
  ),
  subtitle1: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
  subtitle2: GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
  ),
  bodyText1: GoogleFonts.courierPrime(
    textStyle: const TextStyle(
      fontSize: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.normal,
    ),
  ),

  ///По умолчанию для Text виджет
  bodyText2: GoogleFonts.courierPrime(
    textStyle: const TextStyle(
      fontSize: 14,
      letterSpacing: 0.25,
      fontWeight: FontWeight.normal,
    ),
  ),
  button: const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  caption: const TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
    fontWeight: FontWeight.normal,
  ),
  overline: const TextStyle(
    fontSize: 10,
    letterSpacing: 1.5,
    fontWeight: FontWeight.normal,
  ),
);
