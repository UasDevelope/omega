import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/friends_controller.dart';

import '../../utils/constants/color.dart';

class ShareDiaryScreen extends GetView<FriendsController> {
  const ShareDiaryScreen({Key? key}) : super(key: key);

  Widget buildTabContent({required bool isShareTab}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isShareTab
                ? "Share your diary with a friend"
                : "Invite your friends to APEX BIOTICS!",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            isShareTab
                ? "Allow a trusted friend to view your diary entries."
                : "Send them a link to join and start sharing.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: controller.inputController,
            decoration: InputDecoration(
              hintText: "Enter email",
              filled: true,
              fillColor: Colors.grey.shade100,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.handleSubmit(isShareTab),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(isShareTab ? "Share" : "Send Invite"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      init: FriendsController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Friends",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              TabBar(
                controller: controller.tabController,
                labelColor: AppColors.appColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.appColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  // Tab(text: "Share Diary"),
                  Tab(text: "Invite Friends"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildTabContent(isShareTab: false),
                    // buildTabContent(isShareTab: false),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
