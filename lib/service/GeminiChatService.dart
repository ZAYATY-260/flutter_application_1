import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiChatService {
  final String endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
  final String apiKey = 'AIzaSyC1lM58hYp8rrBvSFwX_L66R0SRCQ0zqa8';

  // List of allowed citizen-related topics
  final List<String> allowedTopics = [
    'accident',
    'pothole',
    'fire',
    'streetlight',
    'garbage',
    'trash',
    'water',
    'electricity',
    'noise',
    'crime',
    'flood',
    'road',
    'unsafe',
    'street',
    'problem',
    'issue',
    'emergency',
    'danger',
    'leak',
    'broken',
    'report',
    'damage',
    'construction',
    'maintenance',
  ];

  bool _isRelevant(String message) {
    final lower = message.toLowerCase();
    return allowedTopics.any((topic) => lower.contains(topic));
  }

Future<String> sendMessageToGemini(String message) async {
  if (!_isRelevant(message)) {
    return "⚠️ I'm here to help you avoid danger or trouble spots like potholes, fires, and unsafe areas. Please ask about issues affecting your safety or your surroundings.";
  }

  final prompt = '''
You are Shaware3na Bot, a helpful assistant that advises users about public safety issues. 
Instead of just reporting, you give suggestions to stay safe and avoid dangerous spots.

User issue: "$message"

Please respond with:
1. What the issue means.
2. Whether it's dangerous.
3. What the user should do to stay safe.
4. If relevant, suggest an alternative route or safety tip.
''';

  final response = await http.post(
    Uri.parse('$endpoint?key=$apiKey'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final content = data["candidates"][0]["content"]["parts"][0]["text"];
    return content;
  } else {
    print("Error ${response.statusCode}: ${response.body}");
    return "❗ Something went wrong, please try again.";
  }
}

}
