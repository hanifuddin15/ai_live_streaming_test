import 'package:flutter/material.dart';

class CircleShape extends StatelessWidget {
  const CircleShape({super.key, required this.color, this.size = 12});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
