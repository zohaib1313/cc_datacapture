import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppColors {
  static const blackColor = Color(0xff000F33);
  static const red = Color(0xffD80F0F);

  static const grey = Color(0x33707070);
}

class AppTextStyles {
  static final _fontBold = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.black,
        letterSpacing: 0.5),
  );

  static final _fontBoldMedium = GoogleFonts.poppins(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
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

  static TextStyle _getTextStyleForDevice(
      BuildContext context, double fontSize) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    double scaleFactor = 0.3;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        scaleFactor = 1.3; // Adjust scale factor for tablets/desktops
        break;
      case DeviceScreenType.tablet:
        scaleFactor = 0.5; // Adjust scale factor for tablets
        break;
      default:
        scaleFactor = 0.3; // For phones, keep the default scale factor
    }

    return TextStyle(fontSize: fontSize * scaleFactor);
  }

  static TextStyle textStyleBoldSubTitleLarge =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(24))
          .merge(_fontBold.copyWith(letterSpacing: ScreenUtil().setWidth(1)));

  static TextStyle textStyleNormalLargeTitle =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(24))
          .merge(_fontNormal);

  static TextStyle textStyleBoldBodyMedium =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(18))
          .merge(_fontBoldMedium);

  static TextStyle textStyleNormalBodyMedium =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(18))
          .merge(_fontNormal);

  static TextStyle textStyleBoldBodySmall =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(14))
          .merge(_fontBold);

  static TextStyle textStyleNormalBodySmall =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(14))
          .merge(_fontNormal);

  static TextStyle textStyleBoldBodyXSmall =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(12))
          .merge(_fontBold);

  static TextStyle textStyleNormalBodyXSmall =
      _getTextStyleForDevice(Get.context!, ScreenUtil().setSp(12))
          .merge(_fontNormal);
}
