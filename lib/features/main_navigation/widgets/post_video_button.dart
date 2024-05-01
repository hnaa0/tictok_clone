import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({
    super.key,
    required this.isTapDown,
  });

  final bool isTapDown;

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 20,
            child: Container(
              height: widget.isTapDown ? 33 : 32,
              width: 24,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: widget.isTapDown
                    ? const Color.fromRGBO(150, 212, 240, 1)
                    : const Color(0xFF61D4F0),
                borderRadius: BorderRadius.circular(
                  Sizes.size8,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              height: widget.isTapDown ? 33 : 32,
              width: 24,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: widget.isTapDown
                    ? const Color.fromRGBO(233, 127, 150, 1)
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  Sizes.size8,
                ),
              ),
            ),
          ),
          Container(
            height: widget.isTapDown ? 33 : 32,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size6),
            ),
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: Sizes.size16 + Sizes.size2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
