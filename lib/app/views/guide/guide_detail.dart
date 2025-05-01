import 'package:flutter/material.dart';

import '../../data/models/guides.dart';
import '../../utils/constants/color.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/text/text_widget.dart';

class GuideDetail extends StatelessWidget {
  final Guide guide;

  const GuideDetail({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: guide.title, leading: true),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(guide.imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          TextWidget(
            title: guide.description,
            fontSize: 17,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
            textColor: AppColors.appColor,
          ),
          SizedBox(height: 16),
          ...guide.points.map((item) => _buildGuideItem(
                title: item['title'] ?? '',
                description: item['description'] ?? '',
              )),
        ],
      ),
    );
  }

  Widget _buildGuideItem({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: title,
          fontSize: 18,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w800,
        ),
        TextWidget(
          title: description,
          fontSize: 13,
          textAlign: TextAlign.start,
          textColor: AppColors.textColor.withOpacity(0.7),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
