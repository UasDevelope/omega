import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/home_controller.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/utils/helpers/toast.dart';

import '../../../utils/helpers/notification_service.dart';

class AddSupplementsController extends GetxController {
  final supplementController = TextEditingController();
  final formController = TextEditingController();
  final reasonController = TextEditingController();
  final frequencyController = TextEditingController();
  final timeController = TextEditingController();
  final dosageController = TextEditingController(); // Added dosage controller
  final dayController = TextEditingController();

  final daysOfWeek = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final selectedDayIndex = (-1).obs; // Store the index
  final formKey = GlobalKey<FormState>();

  SupplementServices supplementServices;
  AddSupplementsController({required this.supplementServices});
  // Observable lists

  final supplementOptions = <String>[
    'Apex Test',
    'Vitamin A',
    'Vitamin B1',
    'Vitamin B2',
    'Vitamin B3',
    'Vitamin B5',
    'Vitamin B6',
    'Vitamin B7 (Biotin)',
    'Vitamin B9 (Folate)',
    'Vitamin B12',
    'Vitamin C',
    'Vitamin D',
    'Vitamin E',
    'Vitamin K',
    'Magnesium',
    'Calcium',
    'Zinc',
    'Iron',
    'Potassium',
    'Selenium',
    'Iodine',
    'Chromium',
    'Copper',
    'Manganese',
    'Boron',
    'Molybdenum',
    'Fish Oil',
    'Krill Oil',
    'Algal Oil',
    'Flaxseed Oil',
    'Evening Primrose Oil',
    'Creatine',
    'L-Glutamine',
    'L-Arginine',
    'Citrulline',
    'Beta-Alanine',
    'BCAAs',
    'L-Tyrosine',
    'Taurine',
    'L-Theanine',
    'Collagen',
    'Ashwagandha',
    'Rhodiola Rosea',
    'Panax Ginseng',
    'Turmeric',
    'Ginkgo Biloba',
    'Maca Root',
    'Tongkat Ali',
    'Fenugreek',
    'Saw Palmetto',
    'Milk Thistle',
    'CoQ10',
    'Alpha-Lipoic Acid',
    'Resveratrol',
    'Astaxanthin',
    'Lutein',
    'Zeaxanthin',
    'NAC (N-Acetyl Cysteine)',
    'Berberine',
    'Quercetin',
    'PQQ',
    'SAM-e',
    'Hyaluronic Acid',
    'Melatonin',
    '5-HTP',
    'DHEA',
    'GABA',
    'L-DOPA',
    'Green Tea Extract',
    'Caffeine',
    'Choline',
    'Probiotics',
    'Digestive Enzymes',
    'Psyllium Husk',
    'Apple Cider Vinegar',
    'Glucosamine',
    'Chondroitin',
    'MSM',
    'Boswellia',
    'HMB',
    'CLA',
    'Betaine',
    'Electrolytes',
    'Hydrolyzed Whey Protein',
    'Casein Protein',
    'Whey Protein',
    'Glycine',
    'L-Carnitine',
    'Inositol',
    'DIM',
    'Red Yeast Rice',
    'Artichoke Extract',
    'Grapeseed Extract',
    'Olive Leaf Extract',
    'Elderberry',
    'Peppermint Oil',
    'Chamomile',
    'Valerian Root',
    'Skullcap',
    'Holy Basil',
    'Tribulus Terrestris',
    'Shilajit'
  ].obs;
  List<String> formOptions = [
    'Capsule',
    'Tablet',
    'Powder',
    'Softgel',
    'Liquid',
    'Gummy',
    'Chewable',
    'Lozenge',
    'Effervescent Tablet',
    'Granule',
    'Sachet',
    'Strip',
    'Spray',
    'Drop',
    'Oil',
    'Bar',
    'Gel',
    'Paste',
    'Tincture',
  ];

  final reasonOptions = <String>[
    "General health",
    "Deficiency",
    "Specific condition support",
    "Athletic performance",
    "Cognitive support",
    "Immune support",
    "Stress relief",
    "Heart health",
    "Anti-inflammatory",
    "Antioxidant",
    "Hormonal balance",
    "Sleep aid",
    "Digestive support",
    "Bone health",
    "Muscle recovery",
    "Energy"
  ].obs;
  DateTime getNextOccurrenceOfWeekday({
    required int selectedWeekday, // Monday = 1, Sunday = 7
    required String time, // Format: "hh:mm AM/PM"
  }) {
    final now = DateTime.now();
    final currentWeekday = now.weekday;

    final timeParts = time.split(" ");
    final hourMinute = timeParts[0].split(":");
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    // Convert to 24-hour format
    final isPM = timeParts[1].toUpperCase() == "PM";
    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    // Get difference in days
    int dayDiff = (selectedWeekday - currentWeekday + 7) % 7;
    if (dayDiff == 0 &&
        DateTime(now.year, now.month, now.day, hour, minute).isBefore(now)) {
      dayDiff = 7; // schedule for next week if time already passed today
    }

    final targetDate = now.add(Duration(days: dayDiff));
    return DateTime(
        targetDate.year, targetDate.month, targetDate.day, hour, minute);
  }

  String convertTo24HourFormat(String time) {
    final timeParts = time.split(" ");
    final hourMinute = timeParts[0].split(":");
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final isPM = timeParts[1].toUpperCase() == "PM";

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  void saveSupplementData() async {
    if (formKey.currentState?.validate() ?? false) {
      final scheduledDateTime = getNextOccurrenceOfWeekday(
        selectedWeekday: selectedDayIndex.value,
        time: timeController.text.trim(),
      );
      final formattedTime = convertTo24HourFormat(timeController.text.trim());

      final Map<String, dynamic> data = {
        "name": supplementController.text.trim(),
        "form": formController.text.trim(),
        "reason": reasonController.text.trim(),
        'day': selectedDayIndex.value, // Monday = 1
        "time": formattedTime, // e.g., "14:30"
      };

      try {
        final response = await supplementServices.addSupplement(data);
        if (response.success) {
          // 🔔 Schedule Notification
          final scheduledDateTime = getNextOccurrenceOfWeekday(
            selectedWeekday: selectedDayIndex.value,
            time: timeController.text.trim(),
          );

          await NotificationUtil().scheduleNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: "Appex Biotix",
            body:
                "Time to take your supplement: ${supplementController.text.trim()}",
            userProvidedTime: scheduledDateTime,
          );
          await NotificationUtil().scheduleNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1002,
            title: "Appex Biotix",
            body:
                "you missed your supplement: ${supplementController.text.trim()}",
            userProvidedTime: scheduledDateTime.add(Duration(seconds: 30)),
          );
          // ✅ Refresh and feedback
          Get.find<HomeController>().fetchAllSupplements();
          Get.find<HomeController>().fetchSupplements();
          Get.find<HomeController>().weeklySummry();

          CustomToast.success("Supplement added successfully");
          Get.back();
        } else {
          CustomToast.error("Failed to add supplement");
        }
      } catch (e) {
        CustomToast.error("Error: ${e.toString()}");
        log(e.toString());
      }
    }
  }

  @override
  void onClose() {
    supplementController.dispose();
    formController.dispose();
    reasonController.dispose();
    frequencyController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
