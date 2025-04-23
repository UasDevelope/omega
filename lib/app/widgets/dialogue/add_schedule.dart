import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../button/custom_button.dart';
import '../button/custom_circular_button.dart';
import '../text/text_widget.dart';
import '../text_field/custom_text_field.dart';

class AddScheduleDialogue extends StatelessWidget {
  const AddScheduleDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur Intensity
          child: Container(
            color: AppColors.textColor
                .withValues(alpha: 0.2), // Semi-transparent overlay
          ),
        ),
        Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSize.h2,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: "Add a schedule",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomCircularButton(
                        imagePath: AppAssets.close,
                        onPressed: () {
                          Get.back();
                        }),
                  ],
                ),
                // CustomTextField(
                //     labelText: "Time plans",
                //     hintText: "Administrative times",
                //     imagePath: AppAssets.time,
                //     controller: TextEditingController()),

                // CustomTextField(
                //     labelText: "Which medicine?",
                //     hintText: "Which medications?",
                //     controller: TextEditingController()),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            title: "Save",
                            onPressed: () {
                              Get.back();
                            }))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
