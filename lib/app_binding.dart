
import 'package:get/get.dart';
import 'package:omega/app/controllers/profile_ctrl.dart';
import 'package:omega/app/services/profile.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/views/supplements/controller/ctrl.dart';

import 'app/controllers/BottomNavController.dart';
import 'app/controllers/auth.dart';
import 'app/controllers/splash_controller.dart';
import 'app/services/auth_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => authController(UserService()));
    Get.lazyPut(()=>AddSupplementsController(supplementServices: SupplementServices()));
    Get.lazyPut(()=>ProfileController(profileServices: ProfileServices()));
  }
}
