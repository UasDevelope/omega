import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/source/font_source.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../image/custom_svg.dart';
import '../text/text_widget.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final bool isPassword;
  final bool isDropdown;
  final VoidCallback? onTap; // 👈 Add onTap

  final List<String>? dropdownItems;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.isDropdown = false,
    this.dropdownItems,
    this.borderColor = const Color(0xFFE0E0E0),
    this.backgroundColor = const Color(0xFFF8F8F8),
    this.textColor = Colors.black,
    this.hintColor = const Color(0xFF9E9E9E),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseDecoration = InputDecoration(
      prefixIcon: (prefixIcon != null && prefixIcon!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                prefixIcon!,
                color: hintColor,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            )
          : null),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16, color: hintColor),
      filled: true,
      fillColor: backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );

    if (isDropdown) {
      return DropdownButtonFormField<String>(
        decoration: baseDecoration,
        value: controller.text.isNotEmpty ? controller.text : null,
        items: dropdownItems
            ?.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: TextStyle(color: textColor)),
                ))
            .toList(),
        onChanged: (value) {
          controller.text = value ?? '';
          onChanged?.call(value ?? '');
        },
        validator: validator,
      );
    }

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap, // 👈 Use onTap for textfield

      decoration: baseDecoration,
    );
  }
}
