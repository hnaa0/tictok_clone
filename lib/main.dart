import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

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
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const SignUpScreen());
  }
}
