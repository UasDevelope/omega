
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controllers/auth.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../utils/helpers/app_validator.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text_field/custom_text_field.dart';

class SignUpScreen extends GetView<authController> {
  SignUpScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Obx(()=>LoadingOverlay(isLoading: controller.isLoading.value, child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode:AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo
                  Image.asset(AppAssets.logo),
                  SizedBox(height: AppSize.h2),

                  // Name Field
                  AppTextFormField(
                    validator: AppValidators.validateUserName,
                    controller: controller.nameController,
                    hintText: 'Enter your name',
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.grey.shade100,
                    textColor: Colors.black,
                    hintColor: Colors.grey.shade500,
                  ),

                  // Email Field
                  AppTextFormField(
                    validator: AppValidators.validateEmail,
                    controller: controller.emailController,
                    hintText: 'Enter your email',
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.grey.shade100,
                    textColor: Colors.black,
                    hintColor: Colors.grey.shade500,
                  ),

                  // Password Field
                  AppTextFormField(
                    validator: AppValidators.validatePassword,
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.grey.shade100,
                    textColor: Colors.black,
                    hintColor: Colors.grey.shade500,
                  ),

                  // AppTextFormField(
                  //   validator:  (value) =>
                  //       AppValidators.validateConfirmPassword(value, controller.passwordController.text),
                  //   controller: controller.confrimPasswordController,
                  //   hintText: 'Enter your confirm password',
                  //   borderColor: Colors.grey.shade300,
                  //   backgroundColor: Colors.grey.shade100,
                  //   textColor: Colors.black,
                  //   hintColor: Colors.grey.shade500,
                  // ),
                  // Signup Button
                  SizedBox(height: AppSize.h2),

                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: "Sign Up",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signUpUser();
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSize.h2 / 2),

                  // Login Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.login),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.appColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ))),
    );
  }
}
