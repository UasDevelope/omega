import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/utils/constants/color.dart';
import 'package:omega/app/utils/helpers/app_size.dart';

import '../../widgets/chart/monthly_bar_chart.dart';
import '../../widgets/container/custom_supplement_container.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress',
          style: TextStyle(color: AppColors.textColor),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            spacing: AppSize.h3,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WeeklyBarChart(),
              CustomSupplementContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
