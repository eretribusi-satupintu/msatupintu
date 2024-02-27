import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:satupintu_app/blocs/auth/auth_bloc.dart";
import "package:satupintu_app/ui/pages/home_page.dart";
import "package:satupintu_app/ui/pages/login_page.dart";
import "package:satupintu_app/ui/pages/main_page.dart";
import "package:satupintu_app/ui/pages/splash_page.dart";
import "package:satupintu_app/ui/pages/tagihan_detail_page.dart";

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthGetCurrentUser()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const MainPage(),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
