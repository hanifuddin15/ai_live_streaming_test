import '../../extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    required this.child,
    this.radius = 12,
    this.padding = 20,
    this.shadow,
    this.isBorder = false,
    this.bgColor,
    this.borderColor,
  });

  final Widget child;
  final double radius;
  final double padding;
  final List<BoxShadow>? shadow;
  final bool isBorder;
  final Color? bgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(padding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor ?? context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(radius),
        border:
            isBorder
                ? Border.all(
                  color: borderColor ?? context.colorScheme.outline,
                  width: 2,
                )
                : null,
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}
