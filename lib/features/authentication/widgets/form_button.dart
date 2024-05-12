import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.text,
  });

  final bool disabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      // AnimatedContainer: 컨테이너 장식에 대한 모든 변화를 애니메이션화하는 위젯
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size3),
            color: disabled
                ? isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade300
                : Theme.of(context).primaryColor),
        duration: const Duration(milliseconds: 300),
        // AnimatedDefaultTextStyle: 텍스트가 바뀔 때 애니메이션 효과를 주는 위젯
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          duration: const Duration(milliseconds: 300),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
