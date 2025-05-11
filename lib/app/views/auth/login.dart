import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../controllers/auth.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../utils/helpers/app_validator.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text_field/custom_text_field.dart';
class LoginScreen extends GetView<authController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Obx(() => LoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formKey,
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App Logo
                      Image.asset(AppAssets.logo),
                      SizedBox(height: AppSize.h2),
                      AppTextFormField(
                        validator: AppValidators.validateEmail,
                        controller: controller.emailController,
                        hintText: 'Enter your email',
                        borderColor: Colors.grey.shade300,
                        backgroundColor: Colors.grey.shade100,
                        textColor: Colors.black,
                        hintColor: Colors.grey.shade500,
                      ),
                      AppTextFormField(
                        isPassword:true,
                        validator: AppValidators.validatePassword,
                        controller: controller.passwordController,
                        hintText: 'Enter your password',

                        borderColor: Colors.grey.shade300,
                        backgroundColor: Colors.grey.shade100,
                        textColor: Colors.black,
                        hintColor: Colors.grey.shade500,
                      ),
                      SizedBox(height: AppSize.h2),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: "Login",
                              onPressed: controller.login,
                            ),
                          )
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: controller.goToSignup,
                            child: Text(
                              "Sign Up",
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
