import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const blackColor = Color(0xff000F33);
  static const red = Colors.red;
  static const grey = Color(0x33707070);
}

class AppTextStyles {
  static final _fontBold = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.black,
        letterSpacing: 0.5),
  );

  static final _fontBoldMedium = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.black,
        letterSpacing: 0.5),
  );
  static final _fontNormal = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
          fontStyle: FontStyle.normal,
          color: Colors.black));

  static TextStyle textStyleBoldSubTitleLarge =
      _fontBold.copyWith(fontSize: 28.sp, letterSpacing: 1);

  static TextStyle textStyleNormalLargeTitle =
      _fontNormal.copyWith(fontSize: 28.sp);

  static TextStyle textStyleBoldBodyMedium =
      _fontBoldMedium.copyWith(fontSize: 20.sp);
  static TextStyle textStyleNormalBodyMedium =
      _fontNormal.copyWith(fontSize: 20.sp);

  static TextStyle textStyleBoldBodySmall = _fontBold.copyWith(fontSize: 18.sp);
  static TextStyle textStyleNormalBodySmall =
      _fontNormal.copyWith(fontSize: 18.sp);

  static TextStyle textStyleBoldBodyXSmall =
      _fontBold.copyWith(fontSize: 14.sp);
  static TextStyle textStyleNormalBodyXSmall =
      _fontNormal.copyWith(fontSize: 14.sp);
}
