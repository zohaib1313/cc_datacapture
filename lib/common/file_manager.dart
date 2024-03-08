import 'dart:io';

import 'package:cc_datacapture/common/app_constants.dart';
import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../app_utils/helpers.dart';

class FileManager {
  static Future<void> createFolderAndFiles(
      {required String barcode,
      required String textToSave,
      required List<File> images}) async {
    PermissionStatus storage = await Permission.storage.request();
    if (storage.isGranted && await _checkPermission()) {
      try {
        var externalDir =
            (await ExternalPath.getExternalStorageDirectories()).first;

        Directory folderDir =
            Directory('$externalDir/${AppConstants.appName}/$barcode');

        // Check if the folder already exists
        if (!await folderDir.exists()) {
          await folderDir.create(recursive: true);
        }
        // If the folder already exists, count the existing image files
        int alreadyPresentFileCount =
            folderDir.listSync().whereType<File>().length;

        // Rename the images following the pattern 'image_{existingFileCount + i}.jpg'
        for (int i = 0; i < images.length; i++) {
          File imageFile = File(
              '${folderDir.path}/image_${i + alreadyPresentFileCount}.jpg');
          await imageFile.writeAsBytes(await images[i].readAsBytes());
        }

        // Write text file
        File textFile = File('${folderDir.path}/${barcode}_product.txt');
        if (await textFile.exists()) {
          String existingText = await textFile.readAsString();
          textToSave = '$existingText\n\n$textToSave'; // Append new text
        }
        await textFile.writeAsString(textToSave);

        AppPopUps.showSnackBar(
            message: "Saved at ${folderDir.path}", color: Colors.green);
        print("Saved at ${folderDir.path}");
      } catch (e) {
        print('Error To Save: $e');
      }
    } else {
      AppPopUps.showSnackBar(
          message: "Allow storage permissions", color: Colors.red);
    }
  }

  static Future<bool> _checkPermission() async {
    bool isAllGranted = false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (int.parse(androidInfo.version.release.split(".")[0]) > 10) {
      PermissionStatus externalStoragePermission =
          await Permission.manageExternalStorage.request();
      isAllGranted = externalStoragePermission.isGranted;
      printWrapped(
          "external storage permission = ${externalStoragePermission.toString()}");
    }

    return isAllGranted;
  }
}
