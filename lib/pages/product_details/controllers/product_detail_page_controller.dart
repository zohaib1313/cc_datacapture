import 'dart:io';

import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:cc_datacapture/common/file_manager.dart';
import 'package:cc_datacapture/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailPageController extends GetxController {
  RxBool isLoading = false.obs;
  ProductModel? model;

  RxList<File> imagesList = <File>[].obs;

  void initProcess({required ProductModel model}) {
    this.model = model;
  }

  void pickImages() async {
    // Get max 5 images
    // List<ImageObject>? objects = await Get.to(
    //   ImagePicker(
    //     maxCount: 100,
    //     configs: ImagePickerConfigs()
    //       ..appBarBackgroundColor = Colors.black
    //       ..translateFunc = (name, value) => Intl.message(value, name: name),
    //   ),
    // );
    //
    // objects?.forEach((element) {
    //   imagesList.add(File(element.originalPath));
    // });
  }

  void saveImagesInFolder({required String barCode}) async {
    if (imagesList.isEmpty) {
      AppPopUps.showSnackBar(message: "Add images");
      return;
    }
    isLoading.value = true;
    await FileManager.createFolderAndFiles(
        barcode: barCode, textToSave: "asdfas", images: imagesList);

    isLoading.value = false;
  }
}
