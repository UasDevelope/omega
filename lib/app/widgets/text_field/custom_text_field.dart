import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/source/font_source.dart';
import '../../utils/constants/color.dart';
import '../../utils/helpers/app_size.dart';
import '../image/custom_svg.dart';
import '../text/text_widget.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final bool isPassword;
  final bool isDropdown;
  final VoidCallback? onTap;

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
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final baseDecoration = InputDecoration(
      prefixIcon: (widget.prefixIcon != null && widget.prefixIcon!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                widget.prefixIcon!,
                color: widget.hintColor,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            )
          : null),
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscure ? Icons.visibility_off : Icons.visibility,
                color: widget.hintColor,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            )
          : null,
      hintText: widget.hintText,
      hintStyle: TextStyle(fontSize: 16, color: widget.hintColor),
      filled: true,
      fillColor: widget.backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: widget.borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: widget.borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: widget.borderColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );

    if (widget.isDropdown) {
      return DropdownButtonFormField<String>(
        decoration: baseDecoration,
        value:
            widget.controller.text.isNotEmpty ? widget.controller.text : null,
        items: widget.dropdownItems
            ?.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: TextStyle(color: widget.textColor)),
                ))
            .toList(),
        onChanged: (value) {
          widget.controller.text = value ?? '';
          widget.onChanged?.call(value ?? '');
        },
        validator: widget.validator,
      );
    }

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      obscuringCharacter: '*',
      keyboardType: TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        color: widget.textColor,
        fontWeight: FontWeight.w600,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      decoration: baseDecoration,
    );
  }
}
