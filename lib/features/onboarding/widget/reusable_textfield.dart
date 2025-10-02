import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? title;               // 👈 نص مستقل فوق الحقل
  final bool obscureText;
  final int maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;          // لو احتجت علم/كود دولة
  final TextInputType keyboardType;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,                      // 👈 اختياري
    this.obscureText = false,
    this.maxLength = 100,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // نص العنوان يمين
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF035C6B), // قريب من secondary1
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: AppColors.fieldsAndLogo, // أبيض
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            // حدود عادي/مُفعّل/مُركز
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF6AA5AE), // خط هادئ
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF007793), // primary عند التركيز
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
