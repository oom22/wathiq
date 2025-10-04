import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final List<Widget> children;
  final Color accent;

  const FormCard({super.key, required this.children, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F2F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accent.withOpacity(0.20), // subtle outline
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
