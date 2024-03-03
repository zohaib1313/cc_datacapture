import 'dart:async';

import 'package:cc_datacapture/common/styles.dart';
import 'package:cc_datacapture/generated/assets.dart';
import 'package:cc_datacapture/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static const id = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () => gotoRelevantScreenOnUserType());
  }

  void gotoRelevantScreenOnUserType() {
    Get.offAllNamed(DashBoardPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.iconsLogo,
            height: context.height * 0.5,

            // color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
