import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _chat = InMemoryChatController();
  static const _me = 'user1';
  static const _bot = 'assistant';

  @override
  void initState() {
    super.initState();
    // Optional welcome message
    _chat.insertMessage(
      TextMessage(
        id: _id(),
        authorId: _bot,
        createdAt: DateTime.now().toUtc(),
        text: 'مرحبًا! كيف أقدر أساعدك؟',
      ),
    );
  }

  @override
  void dispose() {
    _chat.dispose();
    super.dispose();
  }

  String _id() => (Random().nextInt(1 << 31)).toString();

  Future<void> _handleSend(String text) async {
    // Show my message immediately
    _chat.insertMessage(
      TextMessage(
        id: _id(),
        authorId: _me,
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );

    try {
      final res = await Gemini.instance.prompt(
        parts: [Part.text(text)],
      ); // ask Gemini
      final reply = (res?.output ?? '').trim();
      _chat.insertMessage(
        TextMessage(
          id: _id(),
          authorId: _bot,
          createdAt: DateTime.now().toUtc(),
          text: reply.isEmpty ? 'لم أحصل على رد، حاول مجددًا.' : reply,
        ),
      );
    } catch (e) {
      _chat.insertMessage(
        TextMessage(
          id: _id(),
          authorId: _bot,
          createdAt: DateTime.now().toUtc(),
          text: 'حدث خطأ: $e',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعد الذكي'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Directionality(
        // RTL for Arabic
        textDirection: TextDirection.rtl,
        child: Chat(
          chatController: _chat,
          currentUserId: _me,
          onMessageSend: _handleSend,
          resolveUser:
              (UserID id) async =>
                  User(id: id, name: id == _me ? 'أنا' : 'المساعد'),
        ),
      ),
    );
  }
}