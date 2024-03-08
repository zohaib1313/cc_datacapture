import 'dart:io';

import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:cc_datacapture/common/common_widgets.dart';
import 'package:cc_datacapture/common/loading_widget.dart';
import 'package:cc_datacapture/common/spaces_boxes.dart';
import 'package:cc_datacapture/common/styles.dart';
import 'package:cc_datacapture/common/widget_helper_mixins.dart';
import 'package:cc_datacapture/generated/assets.dart';
import 'package:cc_datacapture/pages/dashboard/controllers/dashboard_page_controller.dart';
import 'package:cc_datacapture/pages/dashboard/widgets/camera_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  static const id = "/DashBoardPage";

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> with WidgetHelperMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => AppPopUps.showConfirmDialog(
          message: "Are you sure to exit app",
          onSubmit: () {
            Get.back();
          }),
      child: GetX<DashboardPageController>(builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffE5E4E4),
            body: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.red,
                            height: 50,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.iconsLogo,
                                  color: Colors.white,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10.w, top: 30.h, right: 10.w),
                            width: context.width,
                            height: context.height * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: controller.productModel == null
                                  ? _buildQrView(context, controller)
                                  : CameraPreviewWidget(),
                            ),
                          ),
                          vSpace,
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 20),
                              child: GetBuilder<DashboardPageController>(
                                  assignId: true,
                                  id: 'list',
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (controller.imagesList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "Pictures: ${controller.imagesList.length}",
                                                  style: AppTextStyles
                                                      .textStyleBoldBodySmall),
                                              InkWell(
                                                onTap: () {
                                                  AppPopUps.showConfirmDialog(
                                                      message:
                                                          "Are you sure to remove all captured images",
                                                      onSubmit: () {
                                                        controller.imagesList
                                                            .clear();
                                                        controller
                                                            .update(['list']);
                                                      });
                                                },
                                                child: Text("Remove all",
                                                    style: AppTextStyles
                                                        .textStyleBoldBodyXSmall
                                                        .copyWith(
                                                            color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                        Flexible(
                                            child: ListView.builder(
                                          itemCount:
                                              controller.imagesList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              child: Stack(
                                                children: [
                                                  Card(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Image.file(
                                                            controller
                                                                    .imagesList[
                                                                index],
                                                            fit: BoxFit.fill,
                                                            height: 80.h,
                                                          ),
                                                        ),
                                                        Text("${index + 1}"),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 1,
                                                    right: 1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        AppPopUps
                                                            .showConfirmDialog(
                                                                message:
                                                                    "Confirm delete",
                                                                onSubmit: () {
                                                                  controller
                                                                      .imagesList
                                                                      .removeAt(
                                                                          index);
                                                                  controller
                                                                      .update([
                                                                    'list'
                                                                  ]);
                                                                });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.red,
                                                          size: 30.h,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        )),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///product details
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12)),
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Product Details",
                                      style: AppTextStyles
                                          .textStyleBoldBodyMedium
                                          .copyWith(color: AppColors.red),
                                    ),
                                    hSpace,
                                    Image.asset(Assets.iconsPlayic, height: 24),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getRowItem(
                                          key: "Bar Code:",
                                          value:
                                              controller.scannedBarCode.value),
                                      getRowItem(
                                          key: "Item Code:",
                                          value: controller.productModel?.data
                                                  ?.itemDetails?.itemCode ??
                                              '-'),
                                      getRowItem(
                                          key: "Item Price:",
                                          value: controller.productModel?.data
                                                  ?.itemDetails?.posPrice ??
                                              '-'),
                                      getRowItem(
                                          key: "Item Description:",
                                          isRow: false,
                                          value: controller.productModel?.data
                                                  ?.itemDetails?.itemDesc ??
                                              '-'),
                                      SizedBox(height: 100.h),
                                      MyButton(
                                        buttonText: "Scan Barcode",
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        cornerRadius: 4,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xffF80808),
                                            Color(0xffFFB1B1),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp,
                                        ),
                                        postFixIcon: Image.asset(
                                          Assets.iconsBarcode,
                                          width: 40.h,
                                          height: 40.h,
                                        ),
                                        onTap: () {
                                          if (controller.productModel != null) {
                                            AppPopUps.showConfirmDialog(
                                                message:
                                                    "Remove scanned bardcode?",
                                                onSubmit: () {
                                                  setState(() {
                                                    controller.productModel =
                                                        null;
                                                    controller.scannedBarCode
                                                        .value = '';
                                                  });
                                                });
                                          }
                                        },
                                      ),
                                      vSpace,
                                      MyButton(
                                        buttonText: "Take Picture",
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        cornerRadius: 4,
                                        enabled:
                                            controller.productModel != null,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xffFFCB45),
                                            Color(0xffFFD979),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp,
                                        ),
                                        postFixIcon: Image.asset(
                                          Assets.iconsCamera,
                                          width: 40.h,
                                          height: 40.h,
                                        ),
                                        onTap: () async {
                                          controller.takePictureAndSave();
                                        },
                                      ),
                                      vSpace,
                                      GetBuilder<DashboardPageController>(
                                          assignId: true,
                                          id: 'list',
                                          builder: (builder) {
                                            return MyButton(
                                              buttonText: "Save",
                                              color: Colors.black,
                                              textColor: Colors.white,
                                              cornerRadius: 4,
                                              enabled: controller
                                                      .imagesList.isNotEmpty &&
                                                  controller.scannedBarCode
                                                      .isNotEmpty &&
                                                  controller.productModel !=
                                                      null,
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff2DE6FF),
                                                  Color(0xff06C6F0),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp,
                                              ),
                                              postFixIcon: Image.asset(
                                                Assets.iconsSaveic,
                                                width: 40.h,
                                                height: 40.h,
                                              ),
                                              onTap: () async {
                                                controller.saveImagesInFolder(
                                                    barCode: controller
                                                        .scannedBarCode.value);
                                              },
                                            );
                                          }),
                                      vSpace,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                if (controller.isLoading.isTrue)
                  LoadingWidget(
                    onCancel: () {
                      controller.isLoading.value = false;
                    },
                  )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQrView(
      BuildContext context, DashboardPageController controller) {
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: (qrController) {
        controller.qrViewController = qrController;

        ///setting frame refresh on camera recreate to support hard reload....
        try {
          if (Platform.isAndroid) {
            controller.pauseCamera();
          }
          controller.resumeCamera();
          qrController.scannedDataStream.listen((scanData) {
            setState(() {
              if (scanData.code != "") {
                Vibration.vibrate(duration: 200);
                controller.pauseCamera();

                controller.fetchDataAndProceedToNextScreen(
                    scannedResult: scanData);
              }
            });
          });
        } catch (e) {
          print(e);
        }

        /////////
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10.r,
        //  overlayColor: Colors.white,
        borderLength: 30.w,
        borderWidth: 4.w,
        cutOutSize: 250.w,
      ),
      onPermissionSet: (ctrl, p) => controller.onPermissionSet(context, p),
    );
  }
}
