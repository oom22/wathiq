import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;

/// Tiny client for Groq's Allam models (OpenAI-compatible).
class AllamApi {
  AllamApi(this.apiKey);

  final String apiKey;

  static const _endpoint = 'https://api.groq.com/openai/v1/chat/completions';

  /// Sends a single-turn prompt to Allam and returns the assistant text.
  Future<String> chat(String userText) async {
    final res = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'allam-2-7b',
        'messages': [
          {
            'role': 'system',
            'content':
                'أنت مساعد ذكي ومتعاون. أجب بإيجاز وباللغة العربية متى أمكن.',
          },
          {'role': 'user', 'content': userText},
        ],
        'temperature': 0.2,
      }),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final reply = data['choices']?[0]?['message']?['content'] as String?;
      return (reply ?? '').trim();
    } else {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }
  }
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _chat = InMemoryChatController();
  static const _me = 'user1';
  static const _bot = 'assistant';

  late final AllamApi _allam = AllamApi(
    "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",
  );

  String _id() => (Random().nextInt(1 << 31)).toString();

  @override
  void initState() {
    super.initState();
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

  Future<void> _handleSend(String text) async {
    // show my message immediately
    _chat.insertMessage(
      TextMessage(
        id: _id(),
        authorId: _me,
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );

    try {
      final reply = await _allam.chat(text);
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
          text: 'حدث خطأ أثناء الاتصال بـ Allam: $e',
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
        textDirection: TextDirection.rtl, // Arabic layout
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
