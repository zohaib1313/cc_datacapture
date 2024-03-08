import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_page_controller.dart';

class CameraPreviewWidget extends StatelessWidget {
  CameraPreviewWidget({Key? key}) : super(key: key);

  final dashBoardController = Get.find<DashboardPageController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done &&
              snapShot.data != null) {
            dashBoardController.cameraController =
                CameraController(snapShot.data![0], ResolutionPreset.medium);
            return FutureBuilder<void>(
                future: dashBoardController.cameraController.initialize(),
                builder: (context, cSnapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    return CameraPreview(dashBoardController.cameraController);
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
