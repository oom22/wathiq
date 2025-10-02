import 'package:flutter/material.dart';
import 'package:wathiq/features/navigation/screen/navigation_screen.dart';
import 'package:wathiq/features/theme/app_colors.dart';
import 'custom_button.dart';
import 'reusable_textfield.dart';

class SignupWidget extends StatefulWidget {
  final VoidCallback onBack;

  const SignupWidget({super.key, required this.onBack});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("signup"),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xffEAF8FA),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Text( "تسجيل حساب جديد",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.secondary1),),
           Divider(color: AppColors.secondary1,thickness: 1,),
            const SizedBox(height: 20),
            // Text("aaa"),
            ReusableTextField(controller: emailController, hintText: "محمد علي", title: "الاسم الكامل"),

            const SizedBox(height: 5),

            ReusableTextField(controller: emailController, hintText: "Email@mail.com", title: "البريد الإلكتروني"),

            const SizedBox(height: 5),

            ReusableTextField(controller: emailController, hintText: "000-000-000",title: "الهوية / الإقامة"),

            const SizedBox(height: 5),

            ReusableTextField(controller: emailController, hintText: "(966) 500-0000", title: "رقم الجوال"),

            const SizedBox(height: 5),

            ReusableTextField(
              controller: passwordController,
              hintText: "******",
              title: "الرقم السري",
              obscureText: !isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.secondary1
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            CustomButton(text: "تسجيل", onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute<void>(builder:(context) => NavigationScreen()));
            }),
            TextButton(onPressed: widget.onBack, child: const Text("رجوع",
              style: TextStyle(color: AppColors.secondary1), )),

          ],
        ),
      ),
    );
  }
}
