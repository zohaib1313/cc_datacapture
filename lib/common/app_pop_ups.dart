import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/spaces_boxes.dart';
import '../common/styles.dart';
import '../my_application.dart';
import 'common_widgets.dart';

class AppPopUps {
  static bool isDialogShowing = true;

  static Future<bool> showConfirmDialog({
    onSubmit,
    required String message,
  }) async {
    return await showDialog(
            context: myContext!,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Center(
                    child: Container(
                      width: context.width * 0.8,
                      height: 200.h,
                      padding: EdgeInsets.all(20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            message,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textStyleNormalBodySmall
                                .copyWith(color: Colors.black),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Flexible(
                                  child: MyButton(
                                buttonText: 'Yes',
                                onTap: () {
                                  if (onSubmit != null) {
                                    onSubmit();
                                  }
                                  Navigator.pop(context, true);
                                },
                                height: 45.h,
                                cornerRadius: 6,
                                borderColor: Colors.black,
                                textStyle: AppTextStyles
                                    .textStyleNormalBodyMedium
                                    .copyWith(color: Colors.black),
                              )),
                              hSpace,
                              Flexible(
                                  child: MyButton(
                                buttonText: 'Cancel',
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                height: 45.h,
                                cornerRadius: 6,
                                color: Colors.white,
                                borderColor: Colors.black,
                                textStyle:
                                    AppTextStyles.textStyleNormalBodyMedium,
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }) ??
        false;
  }

  static void showSnackBar({
    required String message,
    Color color = Colors.red,
    BuildContext? context,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context ?? myContext!).showSnackBar(snackBar);
  }

  dissmissDialog() {
    if (isDialogShowing) {
      navigatorKey.currentState!.pop();
    }
  }

  static showProgressDialog({BuildContext? context, bool? barrierDismissal}) {
    isDialogShowing = true;
    showDialog(
        useRootNavigator: false,
        useSafeArea: false,
        barrierDismissible: barrierDismissal ?? false,
        context: context!,
        builder: (context) => Center(
              child: Container(
                decoration: BoxDecoration(
                  //color: AppColors(..blackcardsBackground,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(25.r)),
                  boxShadow: [
                    BoxShadow(
                      //  color: AppColors().shadowColor,
                      color: Colors.transparent,
                      spreadRadius: 5.r,
                      blurRadius: 5.r,
                      offset: const Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: 120.h,
                width: 120.h,
                //  child: Lottie.asset(AssetsNames().loader),
                child: const CircularProgressIndicator(),
              ),
            )).then((value) {
      isDialogShowing = false;
    });
  }
}
