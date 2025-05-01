import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/home_controller.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/utils/helpers/toast.dart';

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
    'Vitamin C',
    'Vitamin D',
    'Vitamin E',
    'Vitamin A',
    'Vitamin K',
    'Vitamin B1',
    'Vitamin B2',
    'Vitamin B3',
    'Vitamin B5',
    'Vitamin B6',
    'Vitamin B7 (Biotin)',
    'Vitamin B9 (Folate)',
    'Vitamin B12',
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
    'Glucosamine'
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

  void saveSupplementData() async {
    if (formKey.currentState?.validate() ?? false) {
      final Map<String, dynamic> data = {
        "name": supplementController.text.trim(),
        "form": formController.text.trim(),
        "reason": reasonController.text.trim(),
        'day': selectedDayIndex.value,

        "time": timeController.text.trim(), // Example: "09:00"
      };

      try {
        final response = await supplementServices.addSupplement(data);
        if (response.success) {
          Get.find<HomeController>().fetchAllSupplements();
          Get.find<HomeController>().fetchSupplements();

          CustomToast.success("Supplement added successfully");
          // Optionally clear form or navigate
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
