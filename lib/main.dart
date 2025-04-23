import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/utils/constants/color.dart';
import 'app_binding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <- Must be here
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  initializeFCM();
  runApp(MyApp());
}

Future<void> initializeFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions (iOS-specific)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    String? fcmToken = await messaging.getToken();
    log("✅ FCM Token: $fcmToken");
  } else {
    log("🚫 Notification permissions denied");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Apex",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.appColor,
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.whiteShade,
      ),
      initialRoute: Routes.splashScreen,
      initialBinding: AppBinding(),
      getPages: AppPages.routes,
    );
  }
}
