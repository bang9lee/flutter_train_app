import 'package:flutter/material.dart';
import 'package:flutter_train_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200], // 라이트 모드 배경
        cardColor: Colors.white, // 라이트 모드 카드 색상
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        dividerColor: Colors.grey[400],
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900], // 다크 모드 배경
        cardColor: Colors.grey[800], // 다크 모드 카드 색상
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // 다크 모드에서 흰색 글씨 보장
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        dividerColor: Colors.grey[600],
      ),
      themeMode: _themeMode,
      home: HomePage(onThemeToggle: toggleTheme),
    );
  }
}