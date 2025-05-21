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
    ProfileScreen(),
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
                color: Colors.black.withOpacity(0.1),
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
              showUnselectedLabels: true,
              items: List.generate(5, (index) => _customNavItem(index)),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _customNavItem(int index) {
    final iconPaths = [
      AppAssets.dashboard,
      AppAssets.calender,
      AppAssets.supplement,
      AppAssets.guide,
      AppAssets.setting,
    ];
    final labels = [
      AppStrings.Dashboard,
      AppStrings.Calendar,
      AppStrings.Supplement,
      AppStrings.Guide,
      AppStrings.Setting,
    ];

    return BottomNavigationBarItem(
      icon: Obx(() {
        final isSelected = controller.selectedIndex.value == index;
        return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.appColor.withOpacity(0.1) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            iconPaths[index],
            width: 24,
            height: 24,
            color: isSelected ? AppColors.appColor : Colors.grey,
          ),
        );
      }),
      label: labels[index],
    );
  }
}
