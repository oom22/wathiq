import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';
import 'custom_button.dart';
import 'reusable_textfield.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onBack;

  const LoginWidget({super.key, required this.onBack});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("login"),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xffEAF8FA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           const Text( "تسجيل الدخول",style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.secondary1),),
           Divider(color: AppColors.secondary1,thickness: 1,),
           const SizedBox(height: 10),
          ReusableTextField(
            controller: emailController,
            hintText: "Email@mail.com",
            title: "البريد الإلكتروني",
          ),

          const SizedBox(height: 10),

          ReusableTextField(
            controller: passwordController,
            hintText: "******",
            title: "الرقم السري",
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: AppColors.secondary1,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          CustomButton(text: "تسجيل الدخول", onPressed: () {}),
          TextButton(
            onPressed: widget.onBack,
            child: const Text(
              "رجوع",
              style: TextStyle(color: AppColors.secondary1),
            ),
          ),
        ],
      ),
    );
  }
}
