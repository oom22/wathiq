import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';
import 'custom_button.dart';

class LandingWidget extends StatelessWidget {
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;

  const LandingWidget({
    super.key,
    required this.onLoginTap,
    required this.onSignupTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("landing"),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xffEAF8FA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(text: "تسجيل حساب جديد", onPressed: onSignupTap),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onLoginTap,
            child: const Text.rich(
              TextSpan(
                text: "لديك حساب مسبقاً ؟ ",
                style: TextStyle(fontWeight: FontWeight.w300, color: AppColors.secondary1),
                children: [
                  TextSpan(
                    text: "تسجيل الدخول",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // const Divider(),
          Row(
            children: const [
              Expanded(
                child: Divider(
                  color: AppColors.secondary1,
                  thickness: 0.75,
                  endIndent: 10,
                ),
              ),
              Text(
                "أو",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondary1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColors.secondary1,
                  thickness: 0.75,
                  indent: 10,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondary1,
                    width: 0.75,
                  ),
                ),
                child: const Icon(
                  Icons.phone,
                  size: 25,
                  color: AppColors.secondary1,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondary1, width: 0.75),
                ),
                child: const Icon(
                  Icons.g_mobiledata,
                  size: 30,
                  color: AppColors.secondary1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
