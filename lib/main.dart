import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
// import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
// import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

void main() {
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        // splashColor, highlightColor: onTap시 효과 안보이게
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
