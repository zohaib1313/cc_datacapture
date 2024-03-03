import 'dart:io';

import 'package:cc_datacapture/app_utils/helpers.dart';
import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:cc_datacapture/common/common_widgets.dart';
import 'package:cc_datacapture/common/loading_widget.dart';
import 'package:cc_datacapture/common/spaces_boxes.dart';
import 'package:cc_datacapture/generated/assets.dart';
import 'package:cc_datacapture/pages/dashboard/controllers/dashboard_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key? key}) : super(key: key);
  static const id = "/DashBoardPage";

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Barcode? scannedResult;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => AppPopUps.showConfirmDialog(
          message: "Are you sure to discard post",
          onSubmit: () {
            Get.back();
          }),
      child: GetX<DashboardPageController>(builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leadingWidth: 300,
                      leading: Image.asset(
                        Assets.iconsLogo,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          _buildQrView(context, controller),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 60),
                              child: scannedResult != null
                                  ? Row(
                                      children: [
                                        hSpace,
                                        Expanded(
                                          child: MyButton(
                                            buttonText: "Rescan",
                                            onTap: () {
                                              setState(() {
                                                scannedResult = null;
                                                controller.resumeCamera();
                                              });
                                            },
                                          ),
                                        ),
                                        hSpace,
                                        Expanded(
                                          child: MyButton(
                                            buttonText: "Proceed",
                                            onTap: () {
                                              if (scannedResult != null) {
                                                controller
                                                    .fetchDataAndProceedToNextScreen(
                                                        scannedResult:
                                                            scannedResult!);
                                              }
                                            },
                                          ),
                                        ),
                                        hSpace,
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FutureBuilder(
                                            future: controller.getFlashStatus(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != false) {
                                                return IconButton(
                                                    onPressed: () async {
                                                      controller.toggleFlash();
                                                    },
                                                    icon: const Icon(
                                                        Icons.flash_on,
                                                        color: Colors.white));
                                              } else {
                                                return IconButton(
                                                  onPressed: () {
                                                    controller.toggleFlash();
                                                  },
                                                  icon: const Icon(
                                                      Icons.flash_off,
                                                      color: Colors.white),
                                                );
                                              }
                                            }),
                                        hSpace,
                                        IconButton(
                                            onPressed: () {
                                              controller.flipCamera();
                                            },
                                            icon: const Icon(
                                                Icons.flip_camera_android,
                                                color: Colors.white)),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    var scanArea = (MediaQuery.of(context).size.width < 250 ||
            MediaQuery.of(context).size.height < 250)
        ? 150.0
        : 300.0;
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: (qrController) {
        print("******qr view created******");

        setState(() {
          controller.qrViewController = qrController;
        });

        ///setting frame refresh on camera recreate to support hard reload....
        try {
          if (Platform.isAndroid) {
            qrController.pauseCamera();
          }
          qrController.resumeCamera();
          qrController.scannedDataStream.listen((scanData) {
            print("******listening to stream for qr code******");
            setState(() {
              if (scannedResult?.code != "") {
                printWrapped("Received QR: ${scannedResult?.code}");
                Vibration.vibrate(duration: 500);
                scannedResult = scanData;
                qrController.pauseCamera();
                // qrController.dispose(); // Stop Camera functions

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
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 4,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => controller.onPermissionSet(context, p),
    );
  }
}
