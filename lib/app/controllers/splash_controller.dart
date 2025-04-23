import 'dart:developer';
import 'package:get/get.dart';
import '../data/source/local.dart';
import '../routes/app_routes.dart';
import '../utils/helpers/native_helper.dart';

class SplashController extends GetxController {
  RxString appVersion = 'Version ...'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVersion();
    Future.delayed(Duration(seconds: 5), () async {
      var token = await LocalStorage.getString(LocalStorage.tokenKey);
      log("Token: $token");

      if (token == null || token.isEmpty) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.BOTTOMNAV);
      }
    });
  }

  void fetchVersion() async {
    String version = await NativeHelper.getAppVersion();
    appVersion.value = "Version $version";
  }
}
