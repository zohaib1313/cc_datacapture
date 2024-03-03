import 'package:cc_datacapture/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const SvgViewer(
      {Key? key,
      required this.svgPath,
      this.height,
      this.width,
      this.color,
      this.fit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      key: key,
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: fit,
    );
  }
}

class MyButton extends StatelessWidget {
  final String buttonText;
  final onTap;
  final double? padding;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final Widget? prefixIcon;
  final Widget? postFixIcon;
  final double? height;
  final double? cornerRadius;
  final TextStyle? textStyle;
  final double? leftPadding;
  final double? rightPading;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;

  const MyButton(
      {Key? key,
      required this.buttonText,
      this.onTap,
      this.prefixIcon,
      this.postFixIcon,
      this.padding,
      this.color,
      this.textColor,
      this.cornerRadius,
      this.borderColor,
      this.textStyle,
      this.width,
      this.height,
      this.leftPadding,
      this.child,
      this.borderRadius,
      this.rightPading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding == null ? 0.w : leftPadding!,
            right: rightPading == null ? 0.w : rightPading!),
        child: Container(
          width: width ?? 400.w,
          height: height ?? 55.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor!,
                  ),
            borderRadius: borderRadius ??
                BorderRadius.all(Radius.circular(cornerRadius ?? 26.r)),
            color: color ?? Colors.white,
            boxShadow: [
              if (color == AppColors.blackColor)
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: const Offset(0, 4), // Horizontal: 0, Vertical: 4
                ),
            ],
          ),
          child: Center(
              child: child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      prefixIcon != null
                          ? Padding(
                              padding: const EdgeInsets.all(4),
                              child: prefixIcon)
                          : const IgnorePointer(),
                      Padding(
                        padding: EdgeInsets.all(padding ?? 0.0),
                        child: Text(
                          buttonText,
                          textAlign: TextAlign.center,
                          style: textStyle ??
                              AppTextStyles.textStyleBoldBodySmall.copyWith(
                                  color: textColor ?? AppColors.blackColor),
                        ),
                      ),
                      postFixIcon ?? const IgnorePointer(),
                    ],
                  )),
        ),
      ),
    );
  }
}
