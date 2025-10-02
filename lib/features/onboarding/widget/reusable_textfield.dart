import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final int maxLength;
  final Widget? suffixIcon;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.maxLength = 100,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.fieldsAndLogo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.secondary1,
            // width: 2,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
