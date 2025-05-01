import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/text_widget.dart';
import '../../widgets/text_field/custom_pin_put.dart';

class OtpScreen extends StatelessWidget {
  final controller = Get.find<authController>();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                spacing: AppSize.h2,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    title: "Enter the\nVerification Code",
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: AppSize.h6,
                  ),
                  PinCodeWidget(
                    controller: controller.otpController,
                    onCompleted: (value) {
                      controller.verifyOtp();
                    },
                  ),
                  SizedBox(
                    height: AppSize.h6,
                  ),
                  CustomButton(
                    onPressed: () {
                      controller.verifyOtp();
                    },
                    title: 'Verify OTP',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
