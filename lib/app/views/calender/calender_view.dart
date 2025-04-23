import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/app/services/suplement.dart';

import '../../controllers/home_controller.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/container/custom_calender.dart';
import '../../widgets/container/custom_supplement_container.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(supplementServices: SupplementServices()));
    // controller.fetchAllSupplements();
    return Scaffold(
      appBar: customAppBar(title: "Calendar", action: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCalender(),
              Obx(() {
                final selectedDate = controller.selectedDate.value;
                final cleanSelectedDate = DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day);

                final filteredSupplements =
                    controller.allSuplements.where((supplement) {
                  final createdAt = supplement.createdAt;
                  final cleanCreatedAt =
                      DateTime(createdAt.year, createdAt.month, createdAt.day);

                  print(
                      "Selected: $cleanSelectedDate, Created: $cleanCreatedAt");

                  return cleanCreatedAt == cleanSelectedDate;
                }).toList();

                print("Filtered: ${filteredSupplements.length} items");

                if (filteredSupplements.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        "No supplements found for this day.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filteredSupplements.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final suplements = filteredSupplements[index];
                    return supplementContainer(
                      bgColor: AppColors.softWhite,
                      controller: controller,
                      supplement: suplements,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppSize.h2),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
