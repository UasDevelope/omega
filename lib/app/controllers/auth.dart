import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/utils/helpers/notification_service.dart';

import '../data/source/local.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../utils/helpers/toast.dart';

class authController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();

  final nameController = TextEditingController();
  var isLoading = false.obs;
  UserService userService;
  authController(this.userService);
  final formKey = GlobalKey<FormState>();
  Future<void> signUpUser() async {
    // Generate FCM token

    isLoading.value = true;
    try {
      String deviceToken = await NotificationUtil().getToken();
      log("Device token is $deviceToken");
      Map<String, dynamic> data = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "deviceToken": deviceToken,
      };
      log("Data map is $data");
      var response = await userService.createUser(data);
      if (response.success) {
        Get.toNamed(Routes.otp);
        CustomToast.success("Successfully created user");
      } else {
        CustomToast.error(response.message);
      }
    } catch (e) {
      CustomToast.error("Error:$e");
      log("Error$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    // Generate FCM token
    // RemoteMessage fakeMessage = RemoteMessage(
    //   notification: RemoteNotification(
    //     title: "Test Notification",
    //     body: "This is a locally triggered notification!",
    //   ),
    //   data: {
    //     "notificationType":
    //         "simple", // or "message" if you want to test that part
    //   },
    // );

    // NotificationUtil().showNotification(fakeMessage);
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        String? deviceToken = await NotificationUtil().getToken();
        Map<String, dynamic> loginData = {
          "email": emailController.text,
          "password": passwordController.text,
          "deviceToken": deviceToken,
        };
        var response = await userService.login(loginData);
        if (response.success) {
          LocalStorage.saveString(
              LocalStorage.tokenKey, response.data["data"]["token"]);
          CustomToast.success("Login successfully");
          Get.offAllNamed(Routes.BOTTOMNAV); // or Routes.BOTTOMNAV
        } else {
          Get.toNamed(Routes.otp);
        }
      } catch (e) {
        log(e.toString());
        CustomToast.error("$e");
      } finally {
        isLoading.value = false;
      }
      // TODO: Add your API or login logic here
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;
      var response =
          await userService.verifyOtp(otpController.text, emailController.text);
      if (response.success) {
        CustomToast.success("Successfully Verified");
        Get.offNamed(Routes.login);
      } else {
        CustomToast.error("Invalid otp");
      }
    } catch (e) {
      log(e.toString());
      CustomToast.error("$e");
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignup() {
    Get.offNamed(Routes.signup); // or Routes.signup
  }

  @override
  void onClose() {
    super.onClose();
  }
}
