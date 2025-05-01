import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega/app/data/models/user_model.dart';
import 'package:omega/app/services/profile.dart';

import '../data/source/local.dart';
import '../routes/app_routes.dart';
import '../utils/helpers/toast.dart';

class ProfileController extends GetxController {
  var name = "Max John".obs;
  var email = "maxjohn@gmail.com".obs;

  final ProfileServices profileServices;
  final nameController = TextEditingController();
  final isLoading = false.obs;
  final Rxn<UserModel> user = Rxn<UserModel>();
  final Rxn<File> profileImage = Rxn<File>(); // new reactive image file

  ProfileController({required this.profileServices});
  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Clear the stored token or any other relevant data
      await LocalStorage.deleteValue(
          LocalStorage.tokenKey); // Assuming you are using LocalStorage

      // Optionally, show a success message
      CustomToast.success("Logged out successfully");

      // Navigate to the login screen
      Get.offNamed(
          Routes.login); // Or any route you want to navigate to after logout
    } catch (e) {
      CustomToast.error("Error logging out: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
      log("📸 Picked image: ${picked.path}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    log("🔄 Fetching user profile...");

    try {
      final profileResponse = await profileServices.getProfile();

      if (profileResponse.success && profileResponse.data != null) {
        final profileData = profileResponse.data!;

        user.value = profileData;
        name.value = profileData.name ?? '';
        email.value = profileData.email ?? '';
        nameController.text = profileData.name ?? "name";

        log("✅ Profile fetched: ${profileData.name}");
      } else {
        Get.snackbar(
            "Error", profileResponse.message ?? "Failed to load profile.");
      }
    } catch (e) {
      log("🚨 Error: $e");
      Get.snackbar("Error", "Failed to load profile.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      final response = await profileServices.updateProfile(
        name: nameController.text,
        profilePictureFile: profileImage.value!,
      );

      if (response.success && response.data != null) {
        user.value = response.data;
        name.value = response.data!.name ?? '';
        nameController.text = response.data!.name ?? '';
        fetchProfile();

        Get.snackbar("Success", "Profile updated!");
      } else {
        Get.snackbar("Error", response.message ?? "Failed to update profile.");
      }
    } catch (e) {
      log("🚨 Error during profile update: $e");
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
