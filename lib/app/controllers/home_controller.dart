import 'dart:developer';

import 'package:get/get.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/utils/helpers/toast.dart';

import '../data/models/daily_suppliment.dart';
import '../data/models/supplement.dart';

class HomeController extends GetxController {
  SupplementServices supplementServices;

  var selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  HomeController({required this.supplementServices});

  RxList<SupplementModel> supplements = <SupplementModel>[].obs;
  RxList<SupplementModel> allSuplements = <SupplementModel>[].obs;
  final Rx<DailyDataSuppliment?> dailySupplements =
      Rx<DailyDataSuppliment?>(null);

  @override
  void onInit() {
    super.onInit();

    fetchSupplements();
    fetchAllSupplements();
    weeklySummry();
  }

  var checkedStatusMap = <String, RxBool>{}.obs;

  void toggleCheckbox(bool? value, String supplementId) {
    if (checkedStatusMap.containsKey(supplementId)) {
      final newValue = value ?? false;
      checkedStatusMap[supplementId]!.value = newValue;

      final newStatus = newValue ? "taken" : "pending";

      // 🔄 Update status in supplements list
      final index1 = supplements.indexWhere((item) => item.id == supplementId);
      if (index1 != -1) {
        supplements[index1].status = newStatus;
        supplements.refresh();
      }

      // 🔄 Update status in allSuplements list
      final index2 =
          allSuplements.indexWhere((item) => item.id == supplementId);
      if (index2 != -1) {
        allSuplements[index2].status = newStatus;
        allSuplements.refresh();
      }

      // ✅ Hit the API with correct status
      updateStatus(supplementId, newStatus);
    }
  }

  void initCheckboxState(SupplementModel supplement) {
    if (!checkedStatusMap.containsKey(supplement.id)) {
      final initialValue = supplement.status == "taken"
          ? true
          : false; // or true for pending if needed
      checkedStatusMap[supplement.id] = RxBool(initialValue);
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      Map<String, dynamic> data = {"status": status};
      var response = await supplementServices.updateStatus(id, data);
      if (response.success) {
        CustomToast.success("Status updated to $status");
      }
    } catch (e) {
      CustomToast.error("Error $e");
      log(e.toString());
    }
  }

  void fetchAllSupplements() async {
    try {
      final response = await supplementServices.allSupplements();

      if (response.success && response.data != null) {
        allSuplements.value = response.data!;
      } else {
        CustomToast.error("Failed to fetch supplements: ${response.message}");
        log("Failed error ${response.message}");
      }
    } catch (e) {
      log("Error fetching supplements: $e");
      CustomToast.error("Something went wrong");
    }
  }

  void fetchSupplements() async {
    try {
      final response = await supplementServices.todaySupplements();

      if (response.success && response.data != null) {
        supplements.value = response.data!;
      } else {
        CustomToast.error("Failed to fetch supplements: ${response.message}");
        log("Failed error ${response.message}");
      }
    } catch (e) {
      log("Error fetching supplements: $e");
      CustomToast.error("Something went wrong");
    }
  }

  void weeklySummry() async {
    try {
      final response = await supplementServices.weeklySummry();

      if (response.success && response.data != null) {
        dailySupplements.value = response.data!;
      } else {
        CustomToast.error("Failed to fetch supplements: ${response.message}");
        log("Failed error ${response.message} ${response.data} ${response.success}");
      }
    } catch (e) {
      log("Error fetching supplements: $e");
      CustomToast.error("Something went wrong");
    }
  }
}
