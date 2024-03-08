import 'package:cc_datacapture/common/app_constants.dart';
import 'package:cc_datacapture/common/app_pop_ups.dart';
import 'package:cc_datacapture/common/common_widgets.dart';
import 'package:cc_datacapture/common/loading_widget.dart';
import 'package:cc_datacapture/common/spaces_boxes.dart';
import 'package:cc_datacapture/common/styles.dart';
import 'package:cc_datacapture/common/widget_helper_mixins.dart';
import 'package:cc_datacapture/generated/assets.dart';
import 'package:cc_datacapture/models/product_model.dart';
import 'package:cc_datacapture/pages/product_details/controllers/product_detail_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends GetView<ProductDetailPageController>
    with WidgetHelperMixin {
  ProductDetailPage({Key? key}) : super(key: key);
  static const id = "/ProductDetailPage";
  final ProductModel? productModel = Get.arguments[1];
  final String? barCode = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => AppPopUps.showConfirmDialog(
          message: "Are you sure to discard post",
          onSubmit: () {
            Get.back();
          }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Row(
            children: [
              InkWell(
                  onTap: () {
                    AppPopUps.showConfirmDialog(
                        message: "Are you sure to discard post",
                        onSubmit: () {
                          Get.back();
                        });
                  },
                  child: const Icon(Icons.arrow_back)),
              hSpace,
              Flexible(
                child: Image.asset(
                  Assets.iconsLogo,
                ),
              ),
            ],
          ),
          leadingWidth: 300,
          title: Text(barCode ?? ""),
        ),
        body: SafeArea(
          child: GetX<ProductDetailPageController>(initState: (state) {
            if (productModel != null) {
              state.controller?.initProcess(model: productModel!);
            }
          }, builder: (controller) {
            return Stack(
              children: [
                Container(
                  padding: AppConstants.leftRightPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vSpace,
                      Text("Product Details",
                          style: AppTextStyles.textStyleBoldBodyMedium),
                      getRowItem(
                          key: "Item code:",
                          value:
                              productModel?.data?.itemDetails?.itemCode ?? ''),
                      getRowItem(
                          key: "Item price:",
                          value:
                              productModel?.data?.itemDetails?.posPrice ?? ''),
                      getRowItem(
                          key: "Item description:",
                          isRow: false,
                          value:
                              productModel?.data?.itemDetails?.itemDesc ?? ''),
                      vSpace,
                      Text("Images",
                          style: AppTextStyles.textStyleBoldBodyMedium),
                      vSpace,
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 4.0,
                            mainAxisExtent: 100,
                            childAspectRatio: 1.2,
                          ),

                          itemCount: controller.imagesList.length +
                              1, // Add one for the "Add Picture" button
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ElevatedButton(
                                onPressed: () {
                                  controller.pickImages();
                                },
                                child: const Icon(Icons.add),
                              );
                            } else {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Card(
                                    child: Image.file(
                                      controller.imagesList[index - 1],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                      top: 1,
                                      right: 1,
                                      child: InkWell(
                                        onTap: () {
                                          AppPopUps.showConfirmDialog(
                                              message: "Confirm delete",
                                              onSubmit: () {
                                                controller.imagesList
                                                    .removeAt(index - 1);
                                              });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      MyButton(
                        buttonText: "Save",
                        onTap: () {
                          controller.saveImagesInFolder(
                              barCode: barCode ?? '000');
                        },
                        color: Colors.black,
                        textColor: Colors.white,
                      ),
                      vSpace,
                    ],
                  ),
                ),
                if (controller.isLoading.isTrue)
                  LoadingWidget(
                    onCancel: () {
                      controller.isLoading.value = false;
                    },
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
