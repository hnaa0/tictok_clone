import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraSettingButton extends StatelessWidget {
  final FlashMode flashMode;
  final FlashMode flashModeType;
  final void Function(FlashMode flashMode) setFlashMode;
  final IconData icon;

  const CameraSettingButton({
    super.key,
    required this.flashMode,
    required this.setFlashMode,
    required this.icon,
    required this.flashModeType,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == flashModeType ? Colors.amber.shade300 : Colors.white,
      onPressed: () => setFlashMode(flashModeType),
      icon: Icon(icon),
    );
  }
}
