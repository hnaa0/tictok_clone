import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';

import 'constants/sizes.dart';

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
        primaryColor: const Color(0xFFE9435A),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
        useMaterial3: true,
      ),
      home: Padding(
        padding: const EdgeInsets.all(Sizes.size12),
        child: Container(
          child: const Row(
            children: [
              Text("hi"),
              Gaps.h12,
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
