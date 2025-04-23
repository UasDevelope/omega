import 'package:get/get.dart';
import 'package:omega/app/services/suplement.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(supplementServices: SupplementServices()));
  }
}

