import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double size;
  final Axis? direction;

  const Gap(this.size, {super.key, this.direction});

  @override
  Widget build(BuildContext context) {
    if (direction != null) {
      return direction == Axis.horizontal
          ? SizedBox(width: size)
          : SizedBox(height: size);
    }

    final parent = context.findAncestorWidgetOfExactType<Flex>();

    if (parent != null && parent.direction == Axis.horizontal) {
      return SizedBox(width: size);
    } else {
      return SizedBox(height: size);
    }
  }
}
