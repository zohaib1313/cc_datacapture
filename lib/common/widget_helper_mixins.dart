import 'package:cc_datacapture/common/spaces_boxes.dart';
import 'package:cc_datacapture/common/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin WidgetHelperMixin {
  Widget getRowItem({
    required String key,
    required String value,
    bool isRow = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(4),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(1, 0), // changes position of shadow
            ),
            BoxShadow(
              color: Color(0xffE5E4E4),
              spreadRadius: 2,
              blurRadius: 0,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: isRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(key, style: AppTextStyles.textStyleBoldBodySmall),
                  hSpace,
                  Expanded(
                      child: Text(value,
                          style: AppTextStyles.textStyleNormalBodySmall)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(key, style: AppTextStyles.textStyleBoldBodySmall),
                  hSpace,
                  Text(value, style: AppTextStyles.textStyleNormalBodySmall),
                ],
              ),
      ),
    );
  }
}
