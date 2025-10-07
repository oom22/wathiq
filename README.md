# Wathiq (Flutter)

A real-estate dashboard with an integrated AI assistant.
The app provides property data management, charts & analytics, a stepped “Add Deed” flow, and an **AI chat assistant** (Allam model) for Q&A.

## Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Tech & Packages](#tech--packages)
- [Folder Structure](#folder-structure)
- [Quick Start](#quick-start)
- [Configure Allam API Key](#configure-allam-api-key)
- [Platform Permissions](#platform-permissions)
- [Development Notes](#development-notes)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- 🇸🇦 **Arabic RTL UI** with a consistent design system and custom colors.
- 📊 **Dashboard** including:
  - Bar and Pie charts via `fl_chart`.
  - Statistic cards with formatted numbers.
- 🧭 **Custom bottom navigation** (pill/docked shape with a center “+”).
- 🪜 **Add Deed (Stepper)** using `easy_stepper`:
  - Step 1: Personal info (name, ID, phone, IBAN).
  - Step 2: Upload deed (file/image) + deed/meter/national address fields.
  - Step 3: Summary with “Edit” actions before submission.
- 📎 **File uploads** (pdf/jpg/jpeg/png) via `file_picker`.
- 🤖 **AI Assistant** (Allam):
  - Chat UI powered by `flutter_chat_ui` + `flutter_chat_core`.
  - Q&A with optional **file snippet grounding** (to keep token usage low).

---

## Video

`assets\videos\wathiq.mp4`

---

## Tech & Packages

- **Flutter** (Dart)
- **UI**
  - `flutter_chat_ui` + `flutter_chat_core` (chat experience)
  - `fl_chart` (charts)
  - `easy_stepper` (step indicator)
- **Files / Media**
  - `file_picker`
- **Networking**
  - `http` (calls Allam API)
- **Localization**
  - RTL support and Arabic fonts

---

## Folder Structure

> Simplified; adapt to your current project.

```
lib/
  features/
    add/
      widgets/
        form_card.dart
    dashboard/
      screen/
        dashboard_screen.dart
    navigation/
      screen/
        navigation_screen.dart
    onboarding/
      screen/
        splash_screen.dart
        auth_screen.dart
      widget/
        custom_button.dart
        reusable_textfield.dart
    ai/
      screen/
        ai_assistant_screen.dart   # Allam + Chat UI
  features/theme/
    app_colors.dart

assets/
  images/
  snapshots/
    dashboard_screen.txt           # (optional) AI-readable snippet
```

---

## Quick Start

1) **Requirements**
- Flutter 3.19+ (or your project’s required version)
- Dart 3.x
- Xcode / Android SDKs

2) **Install dependencies**
```bash
flutter pub get
```

3) **Run**
```bash
# Recommended: pass Allam key securely via dart-define
flutter run --dart-define=ALLAM_API_KEY=sk-your-allam-key

---

## Configure Allam API Key

- Get an API key from the Allam provider.
- The code reads the key from a Dart environment define:

```dart
// inside ai_assistant_screen.dart (example)
static const String _apiKey =
  String.fromEnvironment('ALLAM_API_KEY', defaultValue: '');
```

- Run with:
```bash
flutter run --dart-define=ALLAM_API_KEY=sk-your-allam-key
```

> For quick local experiments you *can* hardcode, but it’s **not secure**.

---

## Development Notes

### 1) Chat UI + Allam (minimal example)

```dart
final _chat = InMemoryChatController();
static const _me = 'user1';
static const _bot = 'assistant';

Future<void> _handleSend(String text) async {
  _chat.insertMessage(TextMessage(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    authorId: _me,
    createdAt: DateTime.now().toUtc(),
    text: text,
  ));

  try {
    final reply = await _askAllam(
      system: 'You are a helpful Arabic software assistant.',
      user: text,
    );

    _chat.insertMessage(TextMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      authorId: _bot,
      createdAt: DateTime.now().toUtc(),
      text: (reply ?? '').trim().isEmpty ? 'لم أتلقَّ ردًا.' : reply!.trim(),
    ));
  } catch (e) {
    _chat.insertMessage(TextMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      authorId: _bot,
      createdAt: DateTime.now().toUtc(),
      text: 'حدث خطأ: $e',
    ));
  }
}

Future<String?> _askAllam({required String system, required String user}) async {
  final uri = Uri.parse('https://api.allam.ai/v1/chat/completions');

  final body = jsonEncode({
    'model': 'allam-1-13b-instruct',
    'messages': [
      {'role': 'system', 'content': system},
      {'role': 'user', 'content': user},
    ],
    'max_tokens': 500,
    'temperature': 0.2,
  });

  final res = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    },
    body: body,
  );

  if (res.statusCode >= 200 && res.statusCode < 300) {
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final choices = data['choices'] as List?;
    return (choices != null && choices.isNotEmpty)
        ? choices.first['message']?['content'] as String?
        : null;
  } else {
    throw Exception('Allam error ${res.statusCode}: ${res.body}');
  }
}
```

### 2) Optional: Grounding with a Single File Snippet
- Put a copy of the file you want the model to “see” here:
  ```
  assets/snapshots/dashboard_screen.txt
  ```
- Add to `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - assets/snapshots/dashboard_screen.txt
  ```
- Load the text and include a **small snippet** around the user’s query in the prompt to keep token usage low.

