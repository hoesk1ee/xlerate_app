import 'package:flutter/material.dart';
import 'presentation/pages/feedback_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF8F9FA,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          surface: const Color(
            0xFFF8F9FA,
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Feedback Demo',
      home: const FeedbackPage(),
    );
  }
}
