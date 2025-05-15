import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/views/profile/profile_screen.dart';
import 'package:omega/app/views/supplements/supplements_view.dart';

import '../controllers/BottomNavController.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/color.dart';
import '../utils/constants/strings.dart';
import 'calender/calender_view.dart';
import 'guide/guide_view.dart';
import 'home/home_view.dart';
class BottomNavView extends StatelessWidget {
  final controller = Get.find<BottomNavController>();
  final List<Widget> pages = [
    HomeView(),
    CalenderView(),
    SupplementsView(),
    GuideView(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.appColor,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                _customNavItem(AppAssets.dashboard, AppStrings.Dashboard, 0),
                _customNavItem(AppAssets.calender, AppStrings.Calendar, 1),
                _customNavItem(AppAssets.supplement, AppStrings.Supplement, 2),
                _customNavItem(AppAssets.guide, AppStrings.Guide, 3),
                _customNavItem(AppAssets.setting, AppStrings.Setting, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _customNavItem(
    String iconPath,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Obx(
        () => Image.asset(
          iconPath,
          width: 24, // Keep constant size
          height: 24,
          color: controller.selectedIndex.value == index
              ? AppColors.appColor
              : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
