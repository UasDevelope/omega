import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/views/supplements/add_supplements.dart';

import '../../controllers/home_controller.dart';
import '../../data/models/supplement.dart';
import '../../data/source/format.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/text/text_widget.dart';
import '../image/custom_svg.dart';
import 'custom_container.dart';

class CustomSupplementContainer extends StatelessWidget {
  const CustomSupplementContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Get.put(HomeController(supplementServices: SupplementServices()));
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 6.1,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        spacing: AppSize.h2,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildRowIcon(
                  spacing: AppSize.h1,
                  title: 'Supplements',
                  textColor: AppColors.textColor,
                  assetName: AppAssets.suppliments),
              buildRowIcon(
                  spacing: AppSize.h1,
                  onTap: () {
                    Get.to(AddSupplements());
                  },
                  title: 'Add',
                  textColor: AppColors.appColor,
                  assetName: AppAssets.add),
            ],
          ),
          Obx(() {
            if (homeController.supplements.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    "No supplements available right now",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: homeController.supplements.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  final supplement = homeController.supplements[index];
                  log("AllSupplements$supplement");
                  return supplementContainer(
                    bgColor: AppColors.softWhite,
                    controller: homeController,
                    supplement: supplement,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: AppSize.h2);
                },
              );
            }
          })
        ],
      ),
    );
  }
}

Widget buildRowIcon({
  required String title,
  required Color textColor,
  String? assetName,
  Widget? child,
  double? spacing,
  double? fontSize,
  VoidCallback? onTap,
}) {
  final double effectiveSpacing = spacing ?? AppSize.h2;
  final double effectiveFontSize = fontSize ?? 15;
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: effectiveSpacing,
      children: [
        SizedBox(
          width: AppSize.w2,
        ),
        assetName != null ? CustomSvgIcon(assetName: assetName) : child!,
        TextWidget(
          title: title,
          fontWeight: FontWeight.w500,
          textColor: textColor,
          fontSize: effectiveFontSize,
        ),
        SizedBox(
          width: AppSize.w2,
        ),
      ],
    ),
  );
}

Widget supplementContainer({
  bool? status,
  Color? bgColor,
  required SupplementModel supplement,
  required HomeController controller,
}) {
  final bool preferStatus = status ?? true;
  final Color preferBgColor = bgColor ?? AppColors.whiteShade;
  controller.initCheckboxState(supplement);

  return Obx(() => CustomContainer(
        bgColor: preferBgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Supplement Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title: supplement.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          'Delete Supplement',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.appColor,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete ${supplement.name}?',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.dimGreyColor,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.dimGreyColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.deleteSupplement(supplement.id);
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.errorColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.errorColor,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 8),

            /// Supplement Info Grid
            infoRow("Form", supplement.form),
            infoRow("Reason", supplement.reason),
            infoRow("Day", getDayName(supplement.day)),
            if (preferStatus) infoRow("Intake Time", supplement.time),

            SizedBox(height: 12),

            /// Checkbox Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: controller.checkedStatusMap[supplement.id]?.value ??
                      false,
                  onChanged: (bool? value) =>
                      controller.toggleCheckbox(value, supplement.id),
                  activeColor: AppColors.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 8),
                Text("Taken", style: TextStyle(fontSize: 15)),
              ],
            ),

            SizedBox(height: 12),

            /// Status Row (only if preferStatus is true)
            // if (preferStatus)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRowIcon(
                  spacing: 2,
                  title: "Time: ${supplement.time}",
                  textColor: AppColors.dimGreyColor,
                  assetName: AppAssets.time,
                  fontSize: 12,
                ),
                buildRowIcon(
                  title: "Status: ${supplement.status.capitalize}",
                  textColor: AppColors.dimGreyColor,
                  fontSize: 12,
                  spacing: 2,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: statusColor(supplement.status),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            /// Dates
            if (supplement.schedule.startDate != null)
              infoRow("Start Date", formatDate(supplement.schedule.startDate)),
            if (supplement.schedule.endDate != null)
              infoRow("End Date", formatDate(supplement.schedule.endDate)),

            SizedBox(height: 4),

            /// Created At (optional)
            // infoRow("Added On", formatDate(supplement.createdAt)),
          ],
        ),
      ));
}

Widget infoRow(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor.withOpacity(0.75),
            ),
          ),
        ),
        SizedBox(width: 8),
        Flexible(
          flex: 6,
          child: Text(
            value ?? '',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor.withOpacity(0.85),
            ),
          ),
        ),
      ],
    ),
  );
}
