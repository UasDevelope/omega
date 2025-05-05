import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/utils/helpers/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/utils/constants/color.dart';
import 'app_binding.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print("Background Notification Title: ${message.notification!.title}");
    print("Background Notification Body: ${message.notification!.body}");
  } else {
    print("No notification payload in background message");
  }
  print("Background Data: ${message.data}");

  // Show notification using NotificationUtil
  await NotificationUtil().showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <- Must be here
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation('Asia/Karachi')); // Set your desired timezone

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
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
