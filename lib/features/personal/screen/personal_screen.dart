import 'package:flutter/material.dart';
import 'package:wathiq/features/onboarding/screen/auth_screen.dart';
import 'package:wathiq/features/personal/widgets/profile_option.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/ava (2).png"),
              backgroundColor: Colors.white,
            ),

            const SizedBox(height: 10),

            const Text(
              "مكتب عقاري",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ProfileOption(
                      title: "معلومات المكتب",
                      icon: Icons.receipt_long,
                    ),
                    const SizedBox(height: 10),
                    const ProfileOption(
                      title: "إعدادات الحساب",
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 10),
                    const ProfileOption(
                      title: "الدعم و المساعدة",
                      icon: Icons.chat_bubble_outline,
                    ),
                    const SizedBox(height: 10),
                    const ProfileOption(
                      title: "الشروط والأحكام",
                      icon: Icons.verified_user_outlined,
                    ),
                    const SizedBox(height: 10),
                    const ProfileOption(
                      title: "سياسة الخصوصية",
                      icon: Icons.privacy_tip_outlined,
                    ),
                    const SizedBox(height: 10),

                    ListTile(
                      title: const Text(
                        "تسجيل خروج",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: const Icon(Icons.logout, color: Colors.red),
                      onTap: () {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
