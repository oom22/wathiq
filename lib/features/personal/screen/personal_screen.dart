import 'package:flutter/material.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF035C6B), // خلفية داكنة
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
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _buildProfileOption("معلومات المكتب", Icons.receipt_long),
                    _buildProfileOption("إعدادات الحساب", Icons.person_outline),
                    _buildProfileOption("الدعم و المساعدة", Icons.chat_bubble_outline),
                    _buildProfileOption("الشروط والأحكام", Icons.verified_user_outlined),
                    _buildProfileOption("سياسة الخصوصية", Icons.privacy_tip_outlined),

                    const Spacer(),

                    // زر تسجيل خروج
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "تسجيل خروج",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.red),
                      onTap: () {
                        // TODO: Logout action
                      },
                    ),
                  ],
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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: Icon(icon, color: const Color(0xFF035C6B)),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black54),
      onTap: () {},
    );
  }
}
