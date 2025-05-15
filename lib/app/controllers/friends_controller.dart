import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/services/friends_service.dart';
import 'package:omega/app/views/HelpScreen/HelpScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController inputController = TextEditingController();

  @override
  void onInit() {
    int initialTabIndex = 0;
    if (Get.arguments != null && Get.arguments is int) {
      final arg = Get.arguments as int;
      if (arg >= 0 && arg < 2) {
        initialTabIndex = arg;
      }
    }

    tabController =
        TabController(length: 2, vsync: this, initialIndex: initialTabIndex);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    inputController.dispose();
    super.onClose();
  }

  Future<void> handleSubmit(bool isShareTab) async {
    final input = inputController.text.trim();
    if (input.isEmpty) {
      Get.snackbar("Error", "Please enter a valid email or username");
      return;
    }
    if (isShareTab) {
      FriendsService.shareDiary({"friendEmail": input}).then((value) {
        Get.snackbar("Success", "Diary shared with $input");
      });
    } else {
      // Invite Friend → open email client
      // launchEmail(input);
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: input,
        queryParameters: {
          'subject': 'Join me on ApexBiotics!',
          'body': '''Hey!

Join me on ApexBiotics and add your supplements to your daily diary. Monitoring your progress has never been easier.''',
        },
      );

      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    }
  }
}
