import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/profile_ctrl.dart';
import 'package:omega/app/utils/constants/assets.dart';
import 'package:omega/app/widgets/button/custom_button.dart';
import 'package:omega/app/widgets/text_field/custom_text_field.dart';

import '../../utils/constants/color.dart';

class UpdateProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor:
            AppColors.appColor, // Set app-specific color for the app bar
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image Section
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() {
                  final image = controller.profileImage.value;
                  final networkImage = controller.user.value?.profilePicture;
                  log(networkImage.toString());

                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: image != null
                        ? FileImage(image)
                        : (networkImage != null && networkImage.isNotEmpty
                            ? NetworkImage(networkImage)
                            : AssetImage(AppAssets.noProfile)),
                  );
                }),
              ),
              SizedBox(height: 24),

              // Name Field
              AppTextFormField(
                  controller: controller.nameController, hintText: "Name"),

              SizedBox(height: 20),
              Center(
                child: CustomButton(
                    title: " Save                                             ",
                    onPressed: controller.updateProfile),
              )
              // Save Button
            ],
          ),
        );
      }),
    );
  }
}
