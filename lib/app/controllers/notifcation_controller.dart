import 'dart:developer';

import 'package:get/get.dart';
import 'package:omega/app/services/notification_service.dart';

class NotificationController extends GetxController {
  Future<void> fetchNotification() async {
    var response = await NotificationService.fetchNotifications();
    if (response != null && response.success) {
      log("Response data is $response");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNotification();
  }
}
