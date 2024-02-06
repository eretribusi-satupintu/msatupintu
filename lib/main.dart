import "package:flutter/material.dart";
import "package:satupintu_app/ui/pages/home_page.dart";
import "package:satupintu_app/ui/pages/login_page.dart";
import 'package:satupintu_app/ui/pages/main_page.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool auth = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
        '/home-main': (context) => const MainPage(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}
