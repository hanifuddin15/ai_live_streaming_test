import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryIcon extends StatelessWidget {
  final Widget iconWidget;
  const PrimaryIcon({super.key, required this.iconWidget});

  /// Factory for IconData
  factory PrimaryIcon.fromIconData(
    IconData iconData, {
    double size = 24,
    Color? color,
    Key? key,
  }) {
    return PrimaryIcon(iconWidget: Icon(iconData, size: size, color: color));
  }

  /// Factory for PNG/JPG assets
  factory PrimaryIcon.fromPng(
    String assetPath, {
    double size = 24,
    Color? color,
    Key? key,
  }) {
    return PrimaryIcon(
      iconWidget: Image.asset(
        assetPath,
        width: size,
        height: size,
        color: color,
      ),
    );
  }

  /// Factory for SVG assets
  factory PrimaryIcon.fromSvg(
    String assetPath, {
    double size = 24,
    Color? color,
    Key? key,
  }) {
    return PrimaryIcon(
      iconWidget: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return iconWidget;
  }
}
