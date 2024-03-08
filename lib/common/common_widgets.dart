import 'package:cc_datacapture/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final bool enabled;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;

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
      this.gradient,
      this.rightPading,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding == null ? 0.w : leftPadding!,
            right: rightPading == null ? 0.w : rightPading!),
        child: Container(
          width: width ?? 400.w,
          height: height ?? 65.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor!,
                  ),
            borderRadius: borderRadius ??
                BorderRadius.all(Radius.circular(cornerRadius ?? 26.r)),
            color: enabled ? color ?? Colors.white : Colors.grey,
            gradient: enabled == true ? gradient : null,
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
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(padding ?? 0.0),
                          child: Text(
                            buttonText,
                            textAlign: TextAlign.center,
                            style: textStyle ??
                                AppTextStyles.textStyleBoldBodySmall.copyWith(
                                    color: textColor ?? AppColors.blackColor),
                          ),
                        ),
                      ),
                      if (postFixIcon != null)
                        Expanded(
                          child: postFixIcon!,
                        )
                    ],
                  )),
        ),
      ),
    );
  }
}
