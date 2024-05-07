import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({
    super.key,
    required this.category,
    required this.numbers,
  });

  final String category;
  final String numbers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numbers,
          style: const TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v2,
        Text(
          category,
          style: TextStyle(
            fontSize: Sizes.size12,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
