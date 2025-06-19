import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/profile_ctrl.dart';
import 'package:omega/app/utils/constants/assets.dart';
import 'package:omega/app/widgets/button/custom_button.dart';
import 'package:omega/app/widgets/text_field/custom_text_field.dart';

import '../../utils/constants/color.dart';

class UpdateProfileScreen extends GetView<ProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: AppColors.appColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // In case content overflows
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

                    return networkImage != null && networkImage.isNotEmpty || image != null
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(color: AppColors.appColor, shape: BoxShape.circle),
                            child: Center(child: Text('${controller.user.value?.name.substring(0, 1).toUpperCase()}', style: TextStyle(fontSize: 40, color: Colors.white), textAlign: TextAlign.center, textScaleFactor: 1.5)))
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: image != null ? FileImage(image) : (networkImage != null && networkImage.isNotEmpty ? NetworkImage(networkImage) : AssetImage(AppAssets.noProfile)) as ImageProvider,
                          );
                  }),
                ),
                SizedBox(height: 24),

                // Name
                AppTextFormField(
                  controller: controller.nameController,
                  hintText: "Name",
                ),

                SizedBox(height: 16),

                // Gender
                DropdownButtonFormField<String>(
                  value: 'Male',
                  items: ['Male', 'Female', 'Other'].map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Date of Birth
                AppTextFormField(
                  controller: controller.dobController,
                  hintText: "Date of Birth",
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.appColor,
                              onPrimary: Colors.white,
                              onSurface: Colors.black87,
                            ),
                            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      final formatted = "${picked.day}-${picked.month}-${picked.year}";
                      controller.dobController.text = formatted; // **Comment By Abdul Wahab: Update field on selection**
                    }
                  },
                ),

                SizedBox(height: 16),

                // Zip Code
                AppTextFormField(
                  controller: controller.zipCodeController,
                  hintText: "Zip Code",
                ),

                SizedBox(height: 20),

                // Save Button
                Center(
                  child: CustomButton(
                    title: " Save ",
                    onPressed: controller.updateProfile,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
