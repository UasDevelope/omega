import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:omega/app/services/suplement.dart';

import '../../utils/helpers/app_size.dart';
import '../../utils/helpers/app_validator.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/text_field/custom_text_field.dart';
import 'controller/ctrl.dart';

class AddSupplements extends GetView<AddSupplementsController> {
  const AddSupplements({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AddSupplementsController(supplementServices: SupplementServices()));
    return Scaffold(
      appBar: customAppBar(title: "Add Supplements", leading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              spacing: 20,
              children: [
                SizedBox(
                  height: 50,
                ),
                AppTextFormField(
                  isDropdown: true,
                  dropdownItems: controller.supplementOptions,
                  controller: controller.supplementController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a supplement'
                      : null,
                  hintText: 'Select Supplement',
                  borderColor: Colors.grey.shade300,
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                  hintColor: Colors.grey.shade500,
                ),
                AppTextFormField(
                  isDropdown: true,
                  dropdownItems: controller.formOptions,
                  controller: controller.formController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a form'
                      : null,
                  hintText: 'Select Form',
                  borderColor: Colors.grey.shade300,
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                  hintColor: Colors.grey.shade500,
                ),
                AppTextFormField(
                  isDropdown: true,
                  dropdownItems: controller.reasonOptions,
                  controller: controller.reasonController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a reason'
                      : null,
                  hintText: 'Select Reason',
                  borderColor: Colors.grey.shade300,
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                  hintColor: Colors.grey.shade500,
                ),
                AppTextFormField(
                  isDropdown: true,
                  dropdownItems: controller.daysOfWeek,
                  controller: controller.dayController,
                  onChanged: (selectedDay) {
                    // Find and assign the index of selected day
                    final index = controller.daysOfWeek.indexOf(selectedDay);
                    controller.selectedDayIndex.value = index;
                    controller.dayController.text =
                        selectedDay; // Update visible text
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a day'
                      : null,
                  hintText: 'Select Day of Week',
                  borderColor: Colors.grey.shade300,
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                  hintColor: Colors.grey.shade500,
                ),

                // AppTextFormField(
                //   isDropdown: true,
                //   dropdownItems: controller.frequencyOptions,
                //   controller: controller.frequencyController,
                //   validator: (value) => value == null || value.isEmpty
                //       ? 'Please select frequency'
                //       : null,
                //   hintText: 'Select Frequency',
                //   borderColor: Colors.grey.shade300,
                //   backgroundColor: Colors.grey.shade100,
                //   textColor: Colors.black,
                //   hintColor: Colors.grey.shade500,
                // ),
                AppTextFormField(
                  controller: controller.timeController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select time'
                      : null,
                  hintText: 'Select Time',
                  borderColor: Colors.grey.shade300,
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black,
                  hintColor: Colors.grey.shade500,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      final hour = picked.hour.toString().padLeft(2, '0');
                      final minute = picked.minute.toString().padLeft(2, '0');
                      controller.timeController.text =
                          '$hour:$minute'; // e.g., "17:09"
                    }
                  },
                  //   readOnly: true,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Save",
                        onPressed: controller.saveSupplementData,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
