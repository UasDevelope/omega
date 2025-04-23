import 'package:flutter/material.dart';

import '../../data/source/font_source.dart';
import '../../utils/constants/color.dart';

class RichTextSpanModel {
  final String text;
  final FontSource fontFamily;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  RichTextSpanModel({
    required this.text,
    this.fontFamily = FontSource.poppins,
    this.color = AppColors.textColor,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.textDecoration = TextDecoration.none,
  });
}

class RichTextWidget extends StatelessWidget {
  final List<RichTextSpanModel> textSpanList;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const RichTextWidget({
    super.key,
    required this.textSpanList,
    this.textAlign = TextAlign.center,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        children: textSpanList.map((span) {
          return TextSpan(
            text: span.text,
            style: TextStyle(
              fontFamily: span.fontFamily.value,
              color: span.color,
              fontSize: span.fontSize,
              fontWeight: span.fontWeight,
              decoration: span.textDecoration,
            ),
          );
        }).toList(),
      ),
    );
  }
}
