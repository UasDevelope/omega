import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/constants/color.dart';
import '../text/text_widget.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  const PinCodeWidget({super.key, required this.controller, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 50,
        child: Pinput(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursor: TextWidget(
            title: "|",
            textColor: AppColors.textColor,
          ),
          length: 5,
          controller: controller,
          focusedPinTheme: PinTheme(
            height: 50,
            width: 50,
            textStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.textColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          defaultPinTheme: PinTheme(
            height: 50,
            width: 50,
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.textColor),
                borderRadius: BorderRadius.circular(8)),
          ),
          preFilledWidget: Center(
              child: TextWidget(
            title: "-",
            fontSize: 18,
          )),
          autofocus: true,
          onCompleted: onCompleted,
        ),
      ),
    );
  }
}
