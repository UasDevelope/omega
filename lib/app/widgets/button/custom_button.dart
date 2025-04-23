import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';
import '../image/custom_svg.dart';
import '../text/text_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final String tooltipMessage;
  final Color bgColor, borderColor, textColor, imageColor;

  /// New properties for Image/Icon
  final String? imagePath; // Image path (optional)
  final double imageSize; // Image size

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.bgColor = AppColors.appColor,
    this.horizontalPadding = 12,
    this.verticalPadding = 12,
    this.borderRadius = 12,
    this.borderColor = Colors.transparent,
    this.textColor = AppColors.whiteShade,
    this.imageColor = AppColors.whiteShade,
    this.tooltipMessage = "Click this button",
    this.imagePath, // Image (optional)
    this.imageSize = 24, // Default image size
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.all(8),
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: bgColor,
              border: Border.all(color: borderColor)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Conditionally show image if provided
              if (imagePath != null)
                Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CustomSvgIcon(
                      assetName: imagePath!,
                      width: imageSize,
                      height: imageSize,
                      color: imageColor,
                    )),
              TextWidget(
                title: title,
                textColor: textColor,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
