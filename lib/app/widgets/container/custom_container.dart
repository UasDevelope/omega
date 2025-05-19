import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';

class CustomContainer extends StatelessWidget {
  final Color bgColor;
  final Widget child;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    required this.child,
    this.onTap,
    this.bgColor = AppColors.whiteShade,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6.1,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
