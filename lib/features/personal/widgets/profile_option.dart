import 'package:flutter/material.dart';
import 'package:wathiq/features/theme/app_colors.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: Icon(icon, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }
}
