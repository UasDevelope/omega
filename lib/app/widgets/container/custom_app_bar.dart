import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../views/supplements/add_supplements.dart';
import '../../widgets/text/text_widget.dart';
import 'custom_supplement_container.dart';

AppBar customAppBar({required String title, bool? action, bool? leading}) {
  final bool preferAction = action ?? false;
  final bool preferLeading = leading ?? false;
  return AppBar(
    backgroundColor: AppColors.whiteShade,
    elevation: 0,
    centerTitle: false,
    leadingWidth: preferLeading ? AppSize.getWidth(20) : 0,
    leading: preferLeading
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
            ))
        : Container(),
    title: TextWidget(
      title: title,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    actions: preferAction
        ? [
            InkWell(
              onTap: () {
                Get.to(AddSupplements());
                // Get.dialog(AddScheduleDialogue(), barrierDismissible: false);
              },
              child: buildRowIcon(
                  spacing: AppSize.h1,
                  title: 'Add',
                  textColor: AppColors.appColor,
                  assetName: AppAssets.add),
            ),
          ]
        : [],
  );
}
