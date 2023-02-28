import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget regularText(String text,
    {Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    TextAlign? textAlign,
    double? letterSpacing,
    TextOverflow? overflow,
    int? maxLines}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: GoogleFonts.openSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,

    ),
  );
}