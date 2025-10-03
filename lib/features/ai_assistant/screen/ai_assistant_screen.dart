import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  @override
  Widget build(BuildContext context) {
    Gemini.instance
        .prompt(parts: [Part.text('Write a story about a magic backpack')])
        .then((value) {
          print(value?.output);
        });
    return Container();
  }
}
