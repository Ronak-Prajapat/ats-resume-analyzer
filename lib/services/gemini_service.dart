import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey =
      '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';

  static const List<String> availableModels = [
    'llama-3.3-70b-versatile',
    'llama-3.1-8b-instant',
    'mixtral-8x7b-32768',
  ];

  static Future<String> analyzeResume(String resumeText) async {
    const url = 'https://api.groq.com/openai/v1/chat/completions';

    for (String model in availableModels) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "model": model,
            "messages": [
              {
                "role": "system",
                "content":
                    "You are an expert ATS resume analyzer. Analyze resumes professionally and provide ATS improvement suggestions."
              },
              {
                "role": "user",
                "content": """
Analyze this resume for ATS optimization.

Return response in this exact format:

📊 ATS Score: [Score out of 100]

🔑 Missing Keywords:
• keyword 1
• keyword 2

✅ Strengths:
• strength 1
• strength 2

⚠️ Weaknesses:
• weakness 1
• weakness 2

💡 Suggestions:
• suggestion 1
• suggestion 2
• suggestion 3

Resume:
$resumeText
"""
              }
            ],
            "temperature": 0.7,
            "max_tokens": 1200,
          }),
        );

        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return data['choices'][0]['message']['content'] ??
              'No response generated.';
        } else {
          print("Model Failed: $model");
          print(data);
          continue;
        }
      } catch (e) {
        print("Error with model $model : $e");
        continue;
      }
    }

    return '''
❌ Failed to analyze resume.

Possible reasons:
• Invalid API key
• No internet connection
• Groq API limit exceeded

Get API key:
https://console.groq.com
''';
  }
}