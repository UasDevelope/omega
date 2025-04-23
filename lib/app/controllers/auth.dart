import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/source/local.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../utils/helpers/toast.dart';

class authController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordController = TextEditingController();

  final nameController = TextEditingController();
  var isLoading = false.obs;
  UserService userService;
  authController(this.userService);
  final formKey = GlobalKey<FormState>();
  Future<void> signUpUser() async {
    String? deviceToken = await _getFcmToken(); // Generate FCM token

    isLoading.value = true;
    try {
      Map<String, dynamic> data = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "deviceToken": deviceToken,
      };
      var response = await userService.createUser(data);
      if (response.success) {
        Get.toNamed(Routes.login);
        CustomToast.success(response.message);
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

  Future<String?> _getFcmToken() async {
    try {
      // Get the FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log("FCM Token: $token");
      } else {
        log("FCM Token is null");
      }
      return token;
    } catch (e) {
      log("Error fetching FCM token: $e");
      return null;
    }
  }

  Future<void> login() async {
    String? deviceToken = await _getFcmToken(); // Generate FCM token

    if (formKey.currentState!.validate()) {
      Map<String, dynamic> loginData = {
        "email": emailController.text,
        "password": passwordController.text,
        "deviceToken": deviceToken,
      };
      try {
        isLoading.value = true;

        var response = await userService.login(loginData);
        if (response.success) {
          LocalStorage.saveString(
              LocalStorage.tokenKey, response.data["data"]["token"]);
          CustomToast.success("Login successfully");
          Get.toNamed(Routes.BOTTOMNAV); // or Routes.BOTTOMNAV
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

  void goToSignup() {
    Get.offNamed(Routes.signup); // or Routes.signup
  }

  @override
  void onClose() {
    super.onClose();
  }
}
