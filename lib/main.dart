import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ResumeAnalyzerApp());
}

class ResumeAnalyzerApp extends StatelessWidget {
  const ResumeAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATS Resume Analyzer',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}