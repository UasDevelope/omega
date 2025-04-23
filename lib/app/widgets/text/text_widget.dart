import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/source/font_source.dart';
import '../../utils/constants/color.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontSource fontFamily;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  final Color underLineColor;
  final TextAlign textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  TextWidget({
    super.key,
    required this.title,
    this.textColor = AppColors.textColor,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center,
    this.underLineColor = AppColors.appColor,
    this.textOverflow,
    this.fontFamily = FontSource.poppins,
    this.maxLines, // Initialize maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      textAlign: textAlign,
      overflow:
          textOverflow ?? TextOverflow.clip, // Default to clip if not provided
      softWrap: true,
      maxLines: maxLines, // Set max lines
      style: TextStyle(
        fontFamily: fontFamily.value,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decorationColor: underLineColor,
        decoration: textDecoration,
      ),
    );
  }
}
