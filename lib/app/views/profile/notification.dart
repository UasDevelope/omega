import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notifcation_controller.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/text/text_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.put(NotificationController());

  bool notificationsEnabled = true;
  bool snoozeEnabled = false;

  @override
  void initState() {
    super.initState();
    controller.fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Notifications", leading: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title: "Manage your notifications",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 8),
            TextWidget(
              title:
              "Stay updated on important job activity. Uncheck any notifications you don’t want to receive.",
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              textColor: AppColors.textColor.withOpacity(0.7),
            ),
            const SizedBox(height: 20),
            buildRow(
              "Enabling/Disabling Notifications",
              Switch(
                activeColor: AppColors.appColor,
                inactiveThumbColor: AppColors.softWhite,
                inactiveTrackColor: AppColors.softWhite,
                value: notificationsEnabled,
                onChanged: (val) {
                  setState(() {
                    notificationsEnabled = val;
                  });
                },
              ),
            ),
            buildRow(
              "Snooze Option for Missed Supplements",
              Switch(
                activeColor: AppColors.appColor,
                inactiveThumbColor: AppColors.softWhite,
                inactiveTrackColor: AppColors.textColor.withOpacity(0.6),
                value: snoozeEnabled,
                onChanged: (val) {
                  setState(() {
                    snoozeEnabled = val;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, Widget toggleSwitch) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextWidget(title: title, textColor: AppColors.textColor)),
          toggleSwitch,
        ],
      ),
    );
  }
}
