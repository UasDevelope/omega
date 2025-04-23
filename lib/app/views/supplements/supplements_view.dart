import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/services/suplement.dart';

import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/container/custom_supplement_container.dart';

class SupplementsView extends StatelessWidget {
  const SupplementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController =
        Get.put(HomeController(supplementServices: SupplementServices()));
    homeController.fetchAllSupplements();
    return Scaffold(
      appBar: customAppBar(title: "Supplement"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextWidget(title: "Monday"),
                  homeController.allSuplements.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 200),
                            child: Center(
                              child: Text(
                                "No supplements found at the moment 🧃",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      : Obx(() => ListView.separated(
                            itemCount: homeController.allSuplements.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              final supplement =
                                  homeController.allSuplements[index];
                              log("AllSupplements$supplement");
                              return supplementContainer(
                                bgColor: AppColors.softWhite,
                                controller: homeController,
                                supplement: supplement,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: AppSize.h2);
                            },
                          ))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      tooltipMessage: "Click button to add supplements",
                      horizontalPadding: 18,
                      verticalPadding: 18,
                      title: "Add Supplements",
                      onPressed: () {
                        Get.toNamed(Routes.addSupplements);
                      },
                      imagePath: AppAssets.add,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
