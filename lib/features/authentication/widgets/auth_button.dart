import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final void Function(BuildContext) buttonFunc;
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.buttonFunc,
  });

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox: 크기를 단순히 픽셀로 정하는게 아니라 부모 크기에 비례해서 크기를 정하게 해주는 위젯.
    return GestureDetector(
      onTap: () => buttonFunc(context),
      child: FractionallySizedBox(
        // widthFactor: 부모 너비의 배수 ex) 1=100%
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: Sizes.size1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Align: stack에 있는 위젯 하나의 정렬만 바꿀 수 있게 해주는 위젯.
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.center,
                  width: Sizes.size24,
                  height: Sizes.size24,
                  child: icon,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
