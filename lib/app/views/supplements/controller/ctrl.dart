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
  final isloading=false.obs;
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
    "Apex Test",
    'Vitamin C - Ascorbic acid',
    'Vitamin C - Sodium ascorbate',
    'Vitamin C - Calcium ascorbate',
    'Vitamin C - Ester-C',
    'Vitamin D - D2 (ergocalciferol)',
    'Vitamin D - D3 (cholecalciferol)',
    'Vitamin E - d-alpha tocopherol',
    'Vitamin E - dl-alpha tocopherol',
    'Vitamin E - Tocotrienols',
    'Vitamin A - Retinyl palmitate',
    'Vitamin A - Retinyl acetate',
    'Vitamin A - Beta-carotene',
    'Vitamin K - K1 (phylloquinone)',
    'Vitamin K - K2 (menaquinone-4)',
    'Vitamin K - K2 (menaquinone-7)',
    'Vitamin B1 - Thiamine HCl',
    'Vitamin B1 - Benfotiamine',
    'Vitamin B2 - Riboflavin',
    'Vitamin B2 - Riboflavin-5-phosphate',
    'Vitamin B3 - Niacin',
    'Vitamin B3 - Niacinamide',
    'Vitamin B3 - Inositol hexanicotinate',
    'Vitamin B5 - Calcium pantothenate',
    'Vitamin B5 - Pantethine',
    'Vitamin B6 - Pyridoxine HCl',
    'Vitamin B6 - Pyridoxal-5-phosphate (P5P)',
    'Vitamin B7 - d-Biotin',
    'Vitamin B9 - Folic acid',
    'Vitamin B9 - L-5-MTHF (Quatrefolic)',
    'Vitamin B9 - L-5-MTHF (Metafolin)',
    'Vitamin B12 - Cyanocobalamin',
    'Vitamin B12 - Methylcobalamin',
    'Vitamin B12 - Hydroxocobalamin',
    'Vitamin B12 - Adenosylcobalamin',
    'Magnesium - Citrate',
    'Magnesium - Glycinate',
    'Magnesium - Oxide',
    'Magnesium - Threonate',
    'Magnesium - Malate',
    'Calcium - Carbonate',
    'Calcium - Citrate',
    'Calcium - Malate',
    'Zinc - Picolinate',
    'Zinc - Gluconate',
    'Zinc - Citrate',
    'Zinc - Oxide',
    'Zinc - Bisglycinate',
    'Iron - Ferrous sulfate',
    'Iron - Ferrous gluconate',
    'Iron - Heme iron',
    'Potassium - Citrate',
    'Potassium - Chloride',
    'Potassium - Gluconate',
    'Selenium - Selenomethionine',
    'Selenium - Sodium selenite',
    'Selenium - Selenium yeast',
    'Iodine - Potassium iodide',
    'Iodine - Kelp extract',
    'Chromium - Picolinate',
    'Chromium - Polynicotinate',
    'Chromium - GTF',
    'Copper - Gluconate',
    'Copper - Bisglycinate',
    'Copper - Sulfate',
    'Manganese - Sulfate',
    'Manganese - Gluconate',
    'Manganese - Bisglycinate',
    'Boron - Citrate',
    'Boron - Glycinate',
    'Boron - Aspartate',
    'Molybdenum - Sodium molybdate',
    'Molybdenum - Glycinate',
    'Fish Oil - Triglyceride form',
    'Fish Oil - Ethyl ester form',
    'Fish Oil - Re-esterified triglyceride',
    'Krill Oil - Phospholipid-bound omega-3',
    'Algal Oil - DHA (vegan source)',
    'Flaxseed Oil - Alpha-linolenic acid (ALA)',
    'Evening Primrose Oil - GLA',
    'Creatine - Monohydrate',
    'Creatine - HCl',
    'Creatine - Ethyl ester',
    'Creatine - Kre-Alkalyn',
    'L-Glutamine - Free form',
    'L-Arginine - HCl',
    'L-Arginine - Alpha-ketoglutarate',
    'Citrulline - L-citrulline',
    'Citrulline - Citrulline malate',
    'Beta-Alanine - Free form',
    'BCAAs - Instantized',
    'BCAAs - Fermented',
    'L-Tyrosine - L-tyrosine',
    'L-Tyrosine - N-acetyl L-tyrosine (NALT)',
    'Taurine - Free form',
    'L-Theanine - Suntheanine®',
    'L-Theanine - Standard form',
    'Collagen - Hydrolyzed',
    'Collagen - Peptides',
    'Collagen - Type I',
    'Collagen - Type II',
    'Collagen - Type III',
    'Ashwagandha - KSM-66',
    'Ashwagandha - Sensoril',
    'Ashwagandha - Root powder',
    'Rhodiola Rosea - SHR-5',
    'Rhodiola Rosea - 3% rosavins, 1% salidroside',
    'Panax Ginseng - Standardized extract',
    'Panax Ginseng - Ginsenosides 5–15%',
    'Turmeric - Curcumin',
    'Turmeric - BCM-95',
    'Turmeric - Meriva',
    'Turmeric - Curcumin C3 Complex',
    'Ginkgo Biloba - 24% flavone glycosides, 6% terpene lactones',
    'Maca Root - Gelatinized',
    'Maca Root - Red',
    'Maca Root - Black',
    'Maca Root - Yellow',
    'Tongkat Ali - 100:1 extract',
    'Tongkat Ali - Eurycomanone-standardized',
    'Fenugreek - Testofen®',
    'Fenugreek - Standardized extract',
    'Saw Palmetto - Berry extract',
    'Saw Palmetto - Standardized to fatty acids',
    'Milk Thistle - Silymarin',
    'Milk Thistle - Siliphos®',
    'CoQ10 - Ubiquinone',
    'CoQ10 - Ubiquinol',
    'Alpha-Lipoic Acid - R-ALA',
    'Alpha-Lipoic Acid - S-ALA',
    'Alpha-Lipoic Acid - Stabilized R-ALA',
    'Resveratrol - Trans-resveratrol',
    'Resveratrol - Pterostilbene',
    'Astaxanthin - Haematococcus pluvialis extract',
    'Lutein - Marigold flower extract',
    'Zeaxanthin - Free form',
    'Zeaxanthin - Esters',
    'NAC - N-Acetyl Cysteine',
    'NAC - NACET',
    'Berberine - HCl',
    'Berberine - Sulfate',
    'Berberine - Phytosome',
    'Quercetin - Dihydrate',
    'Quercetin - Phytosome',
    'PQQ - Disodium salt',
    'PQQ - With CoQ10',
    'SAM-e - Tosylate',
    'Hyaluronic Acid - Low-molecular-weight',
    'Hyaluronic Acid - Sodium hyaluronate',
    'Melatonin - Immediate release',
    'Melatonin - Extended release',
    'Melatonin - Sublingual',
    '5-HTP - Griffonia simplicifolia extract',
    'DHEA - Micronized',
    'DHEA - 7-Keto',
    'GABA - Standard',
    'GABA - PharmaGABA®',
    'L-DOPA - Mucuna pruriens extract',
    'Green Tea Extract - EGCG standardized',
    'Green Tea Extract - Decaffeinated',
    'Caffeine - Anhydrous',
    'Caffeine - Natural',
    'Caffeine - Extended-release',
    'Choline - Bitartrate',
    'Choline - Alpha-GPC',
    'Choline - CDP-Choline',
    'Probiotics - Lactobacillus acidophilus',
    'Probiotics - Bifidobacterium bifidum',
    'Probiotics - Saccharomyces boulardii',
    'Digestive Enzymes - Bromelain',
    'Digestive Enzymes - Papain',
    'Digestive Enzymes - Pancreatin',
    'Psyllium Husk - Whole',
    'Psyllium Husk - Powder',
    'Psyllium Husk - Capsules',
    'Apple Cider Vinegar - Liquid',
    'Apple Cider Vinegar - Capsules',
    'Apple Cider Vinegar - Gummies',
    'Glucosamine - Sulfate',
    'Glucosamine - HCl',
    'Chondroitin - Sulfate',
    'MSM - Methylsulfonylmethane',
    'Boswellia - Standardized Extract',
    'Boswellia - AKBA 30%',
    'HMB - Free Acid',
    'HMB - Calcium Salt',
    'CLA - Safflower Oil Derived',
    'CLA - Tonalin',
    'Betaine - Anhydrous',
    'Betaine - HCl',
    'Electrolytes - Sodium',
    'Electrolytes - Potassium',
    'Electrolytes - Magnesium',
    'Hydrolyzed Whey Protein - Isolate',
    'Hydrolyzed Whey Protein - Concentrate',
    'Casein Protein - Micellar',
    'Casein Protein - Calcium Caseinate',
    'Whey Protein - Isolate',
    'Whey Protein - Concentrate',
    'Whey Protein - Hydrolysate',
    'Glycine - Free Form',
    'L-Carnitine - Tartrate',
    'L-Carnitine - Fumarate',
    'L-Carnitine - Acetyl',
    'Inositol - Myo-Inositol',
    'Inositol - D-Chiro Inositol',
    'Dim - Diindolylmethane',
    'Red Yeast Rice - Monacolin K',
    'Artichoke Extract - Standardized to Cynarin',
    'Grapeseed Extract - OPCs 95%',
    'Olive Leaf Extract - Oleuropein 20-40%',
    'Elderberry - Sambucus Extract',
    'Elderberry - Standardized',
    'Peppermint Oil - Enteric-Coated',
    'Peppermint Oil - Softgels',
    'Chamomile - Flower Extract',
    'Chamomile - German',
    'Valerian Root - Standardized Extract',
    'Skullcap - American',
    'Skullcap - Baicalin Extract',
    'Holy Basil - Ocimum sanctum',
    'Holy Basil - Ursolic Acid',
  ];

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
    isloading.value=true;
    if (formKey.currentState?.validate() ?? false) {
      // final scheduledDateTime = getNextOccurrenceOfWeekday(
      //   selectedWeekday: selectedDayIndex.value,
      //   time: timeController.text.trim(),
      // );
      final formattedTime = convertTo24HourFormat(timeController.text.trim());

      final Map<String, dynamic> data = {
        "name": supplementController.text.trim(),
        "form": formController.text.trim(),
        "reason": reasonController.text.trim(),
        'day': selectedDayIndex.value, // Monday = 1
        "time": formattedTime, // e.g., "14:30"
      };
      log("date for this is ${data}");
      try {
        final response = await supplementServices.addSupplement(data);
        if (response.success) {
          // 🔔 Schedule Notification
          // final scheduledDateTime = getNextOccurrenceOfWeekday(
          //   selectedWeekday: selectedDayIndex.value,
          //   time: timeController.text.trim(),
          // );

          // await NotificationUtil().scheduleNotification(
          //   id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          //   title: "Appex Biotix",
          //   body:
          //       "Time to take your supplement: ${supplementController.text.trim()}",
          //   userProvidedTime: scheduledDateTime,
          // );
          // await NotificationUtil().scheduleNotification(
          //   id: DateTime.now().millisecondsSinceEpoch ~/ 1002,
          //   title: "Appex Biotix",
          //   body:
          //       "you missed your supplement: ${supplementController.text.trim()}",
          //   userProvidedTime: scheduledDateTime.add(Duration(seconds: 30)),
          // );
          // ✅ Refresh and feedback
          Get.find<HomeController>().fetchAllSupplements();
          Get.find<HomeController>().fetchSupplements();
          Get.find<HomeController>().weeklySummry();

          // CustomToast.success("Supplement added successfully");
          Get.back();
        } else {
          CustomToast.error("Failed to add supplement");
        }
      } catch (e) {
        CustomToast.error("Error: ${e.toString()}");
        log(e.toString());
      }finally{
        isloading.value=false;
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
