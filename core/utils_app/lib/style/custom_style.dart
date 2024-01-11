import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xff0066AE);
Color primaryLightColor = const Color(0xFF13B9FF);
const double defaultRadius = 8.0;
const double defaultMargin = 24.0;
Color backgroundColor(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;
double maxHeight(BuildContext context) => MediaQuery.of(context).size.height;
double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

class Typo {
  static final TextStyle _defaultStyle = GoogleFonts.inter();

  static final TextStyle _heading = _defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
  );

  static TextStyle h1 = _heading.copyWith(fontSize: 32);
  static TextStyle h2 = _heading.copyWith(fontSize: 24);
  static TextStyle h3 = _heading.copyWith(fontSize: 18);
  static TextStyle h4 = _heading.copyWith(fontSize: 16);
  static TextStyle h5 = _heading.copyWith(fontSize: 10);

  static TextStyle body = _defaultStyle.copyWith(fontSize: 16);
  static TextStyle small = _defaultStyle.copyWith(fontSize: 14);
  static TextStyle caption = _defaultStyle.copyWith(fontSize: 12);

  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}