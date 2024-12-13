import 'package:flutter/material.dart';
import 'package:panda_test_app/core/utils/theme.dart';

class CircularUserAvatar extends StatelessWidget {
  final Image image;
  final double size;
  final Color shadowColor;

  const CircularUserAvatar({
    super.key,
    required this.image,
    this.size = 50.0,
    this.shadowColor = PandaColors.greyDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: image,
      ),
    );
  }
}
