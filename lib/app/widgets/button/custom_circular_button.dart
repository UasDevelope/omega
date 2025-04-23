import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';
import '../image/custom_svg.dart';

/// A custom circular button widget that displays an image and executes a callback when pressed.
///
/// This button supports:
/// - A circular shape.
/// - An image as its child.
/// - A tooltip message for accessibility.
///
/// Example usage:
/// ```dart
/// CustomCircularButton(
///   imagePath: "assets/icons/notification.svg",
///   onPressed: () => print("Button Pressed"),
///   tooltipMessage: "Add Item",
///   size: 50,
/// )
/// ```
class CustomCircularButton extends StatelessWidget {
  /// The path to the image displayed inside the button.
  final String imagePath;

  /// The function to execute when the button is pressed.
  final VoidCallback onPressed;

  /// The size (width & height) of the circular button.
  final double size;

  /// The tooltip message shown when hovering over the button.
  final String tooltipMessage;
  final Color bgColor;
  final Color borderColor;

  /// Creates a circular button with an image and an action.
  const CustomCircularButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    this.borderColor = Colors.transparent,
    this.size = 50,
    this.bgColor = AppColors.whiteShade,
    this.tooltipMessage = "Click this button",
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      decoration: BoxDecoration(
        color: AppColors.whiteShade,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: AppColors.textColor),
      padding: const EdgeInsets.all(8),
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            shape: BoxShape.circle,
            color: bgColor, // Background color
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: CustomSvgIcon(
              assetName: imagePath,
              // width: 34,
              //   height: 34,
            ),
          ),
        ),
      ),
    );
  }
}
