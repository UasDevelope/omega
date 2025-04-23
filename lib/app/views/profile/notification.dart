import '../../utils/constants/assets.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Notifications", leading: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: AppSize.h2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title: "Manage your notifications",
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            TextWidget(
              title:
                  "Stay updated on important job activity. Uncheck any notifications you don’t want to receive.",
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              textColor: AppColors.textColor.withValues(alpha: 0.7),
            ),
            buildRow(
                "Enabling/Disabling Notifications",
                isWidget: true,
                Switch(
                  activeColor: AppColors.appColor,
                  inactiveThumbColor: AppColors.softWhite,
                  inactiveTrackColor: AppColors.softWhite,
                  value: true,
                  onChanged: (onChanged) {},
                )),
            buildRow(
                isWidget: true,
                "Snooze Option for Missed Supplements",
                Switch(
                  activeColor: AppColors.appColor,
                  inactiveThumbColor: AppColors.softWhite,
                  inactiveTrackColor:
                      AppColors.textColor.withValues(alpha: 0.6),
                  value: false,
                  onChanged: (onChanged) {},
                )),
          ],
        ),
      ),
    );
  }
}

Widget buildRow(String title1, dynamic title2,
    {Color color = AppColors.textColor,
    Color? secondColor,
    bool isWidget = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      /// First column (always text)
      TextWidget(
        title: title1,
        textColor: color,
      ),

      /// Second column (text or widget)
      Expanded(
        child: isWidget
            ? Align(
                alignment: Alignment.centerRight,
                child: title2, // Directly use widget
              )
            : TextWidget(
                title: title2.toString(),
                textAlign: TextAlign.end,
                textColor: secondColor ?? color, // Allow different color
              ),
      ),
    ],
  );
}
