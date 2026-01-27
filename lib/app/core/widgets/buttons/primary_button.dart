import '../gap/gap.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double? width;
  final double? height;

  /// Optional icon to show before the text
  final IconData? icon;

  /// Optional icon size
  final double iconSize;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.width,
    this.height = 48,
    this.icon,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: iconSize, color: textColor ?? Colors.white),
              const Gap(8), // gap between icon and text
            ],
            Text(text, style: TextStyle(color: textColor ?? Colors.white)),
          ],
        ),
      ),
    );
  }
}
