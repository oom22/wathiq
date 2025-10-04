import 'package:flutter/material.dart';
import 'package:wathiq/features/onboarding/screen/auth_screen.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // خلفية داكنة
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // 🟢 صورة البروفايل
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/ava (2).png"),
              backgroundColor: Colors.white,
            ),

            const SizedBox(height: 10),

            // 🟢 اسم المكتب
            const Text(
              "مكتب عقاري",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // 🟢 الكرت الأبيض
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildProfileOption("معلومات المكتب", Icons.receipt_long),
                      _buildProfileOption(
                        "إعدادات الحساب",
                        Icons.person_outline,
                      ),
                      _buildProfileOption(
                        "الدعم و المساعدة",
                        Icons.chat_bubble_outline,
                      ),
                      _buildProfileOption(
                        "الشروط والأحكام",
                        Icons.verified_user_outlined,
                      ),
                      _buildProfileOption(
                        "سياسة الخصوصية",
                        Icons.privacy_tip_outlined,
                      ),

                      // زر تسجيل خروج
                      ListTile(
                        leading: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.red,
                        ),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget مساعد لكل خيار
  Widget _buildProfileOption(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.black54,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          textAlign: TextAlign.right,
        ),
        trailing: Icon(icon, color: const Color(0xFF035C6B)),
        onTap: () {},
      ),
    );
  }
}
