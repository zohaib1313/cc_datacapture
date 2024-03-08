import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cc_datacapture/app_utils/helpers.dart';
import 'package:cc_datacapture/app_utils/user_defaults.dart';
import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:cc_datacapture/models/auth_model.dart';
import 'package:cc_datacapture/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../common/file_manager.dart';

class DashboardPageController extends GetxController {
  RxBool isLoading = false.obs;

  ProductModel? productModel;

  List<File> imagesList = <File>[];

  late CameraController cameraController;
  late List<CameraDescription> camerasList;

  RxString scannedBarCode = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (UserDefaults.getUserSession()?.accessToken == null) {
      updateToken();
    }
  }

  QRViewController? qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void toggleFlash() async {
    await qrViewController?.toggleFlash();
  }

  void flipCamera() async {
    await qrViewController?.flipCamera();
  }

  void resumeCamera() async {
    await qrViewController?.resumeCamera();
  }

  void pauseCamera() async {
    await qrViewController?.pauseCamera();
  }

  Future<bool?> getFlashStatus() async {
    return await qrViewController?.getFlashStatus();
  }

  void onPermissionSet(BuildContext context, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }

  void fetchDataAndProceedToNextScreen({required Barcode scannedResult}) async {
    isLoading.value = true;

    final url =
        'https://api-prod.retailsso.com/v1/smapp/productdetails?barcode=${scannedResult.code}';
    printWrapped(url.toString());

    var headers = {
      'accessToken': UserDefaults.getUserSession()?.accessToken ?? "",
      'Accept': 'application/json',
      'appId': 'IOS',
      'langCode': 'en',
      'appVersion': '20620',
      'countrycode': 'PK',
      'storecode': '504',
      'env': 'Test',
    };
    var request = http.Request('GET', Uri.parse(url));
    request.body = '''''';
    request.headers.addAll(headers);

    var streamResponse = await http.Response.fromStream(await request.send());
    var resBody = streamResponse.body;
    isLoading.value = false;
    printWrapped(resBody);

    if (streamResponse.statusCode == 200) {
      final tempModel = ProductModel.fromJson(jsonDecode(resBody));
      String statusCode = tempModel.meta?.statusCode.toString() ?? "";
      if (statusCode == "200") {
        isLoading.value = true;
        productModel = tempModel;
        isLoading.value = false;
        scannedBarCode.value = scannedResult.code ?? '';
      } else if (statusCode == "401") {
        await updateToken();
        fetchDataAndProceedToNextScreen(scannedResult: scannedResult);
      } else {
        AppPopUps.showSnackBar(
            message: tempModel.meta?.message ?? "something went wrong");
        resumeCamera();
      }
    } else if (streamResponse.statusCode == 401) {
      await updateToken();
      fetchDataAndProceedToNextScreen(scannedResult: scannedResult);
    }
  }

  updateToken() async {
    isLoading.value = true;
    printWrapped("updating token");
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://maf-retail-sandbox.apigee.net/v1/unmannedstorems/authtoken'));
    request.body = '''''';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var streamResponse = await http.Response.fromStream(response);
      var resBody = streamResponse.body;
      AuthModel authModel = AuthModel.fromJson(jsonDecode(resBody));
      UserDefaults.saveUserSession(authModel);
    } else {
      print(response.reasonPhrase);
    }
    isLoading.value = false;
  }

  void saveImagesInFolder({required String barCode}) async {
    if (imagesList.isEmpty) {
      AppPopUps.showSnackBar(message: "Add images");
      return;
    } else if (productModel == null) {
      AppPopUps.showSnackBar(message: "Barcode not scanned");
      return;
    }
    isLoading.value = true;
    await FileManager.createFolderAndFiles(
      barcode: barCode,
      textToSave: productModel?.toJson().toString() ?? '',
      images: imagesList,
    );
    scannedBarCode.value = '';
    productModel = null;
    imagesList.clear();
    isLoading.value = false;
  }

  void takePictureAndSave() async {
    await cameraController.setFocusMode(FocusMode.locked);
    await cameraController.setExposureMode(ExposureMode.locked);
    await cameraController.setFlashMode(FlashMode.off);
    XFile file = await cameraController.takePicture();

    imagesList.add(File(file.path));
    update(['list']);
  }
}
