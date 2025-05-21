import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/notification_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    NotificationUtil().allTasks(context);
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // RichTextWidget(
                  //   textAlign: TextAlign.center,
                  //   textSpanList: [
                  //     RichTextSpanModel(
                  //       text: "Welcome to ",
                  //       fontSize: 32,
                  //     ),
                  //     RichTextSpanModel(
                  //       text: "APEX",
                  //       fontSize: 40,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.appColor,
                  //     ),
                  //     RichTextSpanModel(text: "\n"),
                  //     RichTextSpanModel(
                  //       text: "BIOTICS",
                  //       fontSize: 40,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.appColor,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: AppSize.h2),
                  // TextWidget(
                  //   title: "Elevate your future",
                  //   fontSize: 16,
                  //   textColor: Colors.grey,
                  //   textAlign: TextAlign.center,
                  //   fontFamily: FontSource.poppins,
                  // ),
                  // SizedBox(height: AppSize.getHeight(10)),
                  //
                  // // Logo
                  Image.asset(
                    AppAssets.xLogo,
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
            ),
          ),

          // Version at the bottom
// Inside Positioned (in SplashScreen)

          // Positioned(
          //   bottom: 20,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Obx(() {
          //       return TextWidget(
          //         title: Get.find<SplashController>().appVersion.value,
          //         fontSize: 12,
          //         textColor: Colors.grey,
          //         fontFamily: FontSource.poppins,
          //       );
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
