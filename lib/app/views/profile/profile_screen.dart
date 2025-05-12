import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:omega/app/views/profile/updatee.dart';

import '../../controllers/profile_ctrl.dart';
import '../../data/source/local.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../utils/helpers/toast.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/container/custom_supplement_container.dart';
import '../../widgets/text/text_widget.dart';
import '../HelpScreen/HelpScreen.dart';
import 'friends.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Setting"),
      body: Obx(() {
        // Check if loading state is true
        if (controller.isLoading.value) {
          return LoadingOverlay(
            isLoading: true,
            child: Center(
              child:
                  CircularProgressIndicator(), // You can customize the loading indicator
            ),
          );
        }

        // Ensure user data is available before rendering
        final user = controller.user.value;
        if (user == null) {
          return Center(
            child: TextWidget(
              title: "User data not found",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        // Continue with the UI rendering once data is available
        return LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSize.h2,
                children: [
                  CustomContainer(
                    onTap: () => Get.to(UpdateProfileScreen()),
                    child: ListTile(
                      title: TextWidget(
                        title: user.name ??
                            'No name provided', // Safely handle null value
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: TextWidget(
                        title: controller.email.value.isNotEmpty
                            ? controller.email.value
                            : 'No email provided', // Safely handle null or empty email
                        textAlign: TextAlign.start,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: controller
                                .user.value!.profilePicture.isNotEmpty
                            ? NetworkImage(controller.user.value!.profilePicture
                                .toString()) // If API provides a profile image URL
                            : AssetImage(AppAssets.noProfile)
                                as ImageProvider, // Otherwise use the asset image
                        backgroundColor: AppColors.appColor,
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                  TextWidget(
                    title: "Account",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomContainer(
                    child: Column(
                      spacing: AppSize.h2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Get.toNamed(Routes.notification),
                          child: buildRowIcon(
                            title: "Notifications",
                            textColor: AppColors.textColor,
                            assetName: AppAssets.simpleNotification,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(HelpScreen()),
                          child: buildRowIcon(
                            title: "Help",
                            textColor: AppColors.textColor,
                            assetName: AppAssets.support,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: buildRowIcon(
                        //     title: "Progress",
                        //     textColor: AppColors.textColor,
                        //     assetName: AppAssets.progress,
                        //   ),
                        // ),
                        InkWell(
                          onTap: () => Get.to(ShareDiaryScreen()),
                          child: buildRowIcon(
                            title: "Friends",
                            textColor: AppColors.textColor,
                            assetName: AppAssets.invite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0), // Adjust height (full button height)
                      minimumSize: Size(double.infinity,
                          50), // Full width and height of the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      await LocalStorage.deleteValue(LocalStorage
                          .tokenKey); // Assuming you are using LocalStorage
                      // Optionally, show a szuccess message
                      CustomToast.success("Logged out successfully");

                      // Navigate to the login screen
                      Get.offNamed(Routes.login);
                    },
                    icon: Icon(Icons.exit_to_app, size: 20),
                    label: Text(
                      'Log Out',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
