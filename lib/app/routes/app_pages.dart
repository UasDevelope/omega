import 'package:get/get.dart';
import 'package:omega/app/views/auth/otp.dart';

import '../../app_binding.dart';
import '../bindings/home_binding.dart';
import '../data/models/guides.dart';
import '../views/auth/login.dart';
import '../views/auth/signup.dart';
import '../views/bottom_nav_view.dart';
import '../views/guide/guide_detail.dart';
import '../views/home/home_view.dart';
import '../views/profile/notification.dart';
import '../views/splash/splash_screen.dart';
import '../views/supplements/add_supplements.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BOTTOMNAV,
      page: () => BottomNavView(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => NotificationScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.addSupplements,
      page: () => AddSupplements(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignUpScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => OtpScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.guideDetail,
      page: () => GuideDetail(guide: Get.arguments as Guide),
      binding: AppBinding(),
    ),
  ];
}
