import 'dart:convert';
import 'dart:developer' as log;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:omega/app/data/source/local.dart';

class NotificationUtil {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static bool _isInitialized = false;

  void allTasks(BuildContext context) async {
    await requestNotificationPermission();
    await firebaseInit(context);
    await onInteractMessage(context);
    await getToken().then((value) async {
      String? tokenString = await LocalStorage.getString(LocalStorage.fmcToken);
      log.log("Token is $tokenString");
      if (tokenString != "" && tokenString != value) {
        LocalStorage.saveString(LocalStorage.fmcToken, value);
        log.log("Value is $value");
        // PrefUtil.saveToken(value);
      }
    });
  }

  Future<void> firebaseInit(BuildContext context) async {
    if (!_isInitialized) {
      await initNotification(context);
      _isInitialized = true;
    }

    FirebaseMessaging.onMessage.listen((message) {
      String? title = message.notification?.title;
      String? body = message.notification?.body;

      log.log("Notification Title: ${title ?? 'No Title'}");
      log.log("Notification Body: ${body ?? 'No Body'}");
      log.log("Data: ${message.data.toString()}");

      if (Platform.isAndroid || Platform.isIOS) {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    log.log("Preparing to show notification");

    AndroidNotificationDetails androidSimpleNotificationDetails =
        const AndroidNotificationDetails(
      "general_notifications",
      "General Notifications",
      channelDescription: "Basic notification for all alerts",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );

    const DarwinNotificationDetails darwinSimpleNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails simpleNotificationDetails = NotificationDetails(
      android: androidSimpleNotificationDetails,
      iOS: darwinSimpleNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // random unique ID
      message.notification?.title ?? "Notification",
      message.notification?.body ?? "You have a new update",
      simpleNotificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  Future<void> onInteractMessage(BuildContext context) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      handelMessage(context, message);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handelMessage(context, event);
    });
  }

  void handelMessage(BuildContext context, RemoteMessage message) {
    log.log("Handling message - Message Data: ${message.data}");
    if (message.notification != null) {
      log.log("Handling message - Title: ${message.notification!.title}");
      log.log("Handling message - Body: ${message.notification!.body}");
    } else {
      log.log("Handling message - No notification payload found");
    }
  }

  Future<String> getToken() async {
    try {
      await Future.delayed(Duration(seconds: 3)); // Delay for 3 seconds

      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      log.log("Apns token is $apnsToken");
      if (apnsToken == null) {
        log.log("APNS token not available yet.");
        return "APNS token not set";
      }

      String? token = await FirebaseMessaging.instance.getToken();
      log.log("Retrieved FCM token: $token");
      return token ?? "123";
    } catch (error) {
      log.log("Error getting token: $error");
      return error.toString();
    }
  }

  Future<void> isTokenChange() async {
    firebaseMessaging.onTokenRefresh.listen((String? event) async {
      log.log("Token refreshed: $event");
    });
  }

  Future<void> initNotification(BuildContext context) async {
    log.log("Initializing notifications");

    var androidInitialization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitialization = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          "message_category",
          actions: [
            DarwinNotificationAction.text(
              "REPLY_ACTION",
              "Reply",
              buttonTitle: "Send",
              placeholder: "Type your reply...",
              options: {DarwinNotificationActionOption.foreground},
            ),
            DarwinNotificationAction.plain("SEEN_ACTION", "Mark as Seen",
                options: {DarwinNotificationActionOption.foreground}),
            DarwinNotificationAction.plain("MUTE_ACTION", "Mute",
                options: {DarwinNotificationActionOption.foreground}),
          ],
        ),
      ],
    );

    var initializationSetting = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log.log(
            "Notification Response - Action ID: ${response.actionId}, Payload: ${response.payload}");
        switch (response.actionId) {
          case "REPLY_ACTION":
            if (response.input != null && response.input!.isNotEmpty) {
              log.log("Reply Received: ${response.input}");
            }
            break;
          case "SEEN_ACTION":
            log.log("Notification marked as seen");
            break;
          case "MUTE_ACTION":
            log.log("Notification muted");
            break;
          default:
            log.log("Unknown action triggered");
        }
      },
    );

    log.log("Notifications: Initialized once");
    log.log("Notifications: initialized");
  }

  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log.log("Notification permission granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log.log("Notification permission denied");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log.log("Notification permission granted provisionally");
    }
  }
}
