import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/services/friends_service.dart';
import 'package:omega/app/views/HelpScreen/HelpScreen.dart';

class FriendsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController inputController = TextEditingController();

  @override
  void onInit() {
    tabController = TabController(length: 1, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    inputController.dispose();
    super.onClose();
  }

  void handleSubmit(bool isShareTab) {
    final input = inputController.text.trim();
    if (input.isNotEmpty) {
      if (!isShareTab) {
        launchEmail(
            input,);
        // FriendsService.shareDiary({"email": input}).then((value) {});
      } else {
        FriendsService.inviteFriends({"email": input}).then((value) {});
      }
      // Handle the action
      // Get.snackbar(
      //   "Success",
      //   isShareTab ? "Diary shared with $input" : "Invitation sent to $input",
      // );
    } else {
      Get.snackbar("Error", "Please enter a valid email or username");
    }
  }
}
