import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconTitleSubtitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  /// Layout
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// Icon
  final Widget icon;
  final double iconSize;
  final EdgeInsets iconPadding;

  /// Container style
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  /// subtitle
  final int? subtitleMaxLines;
  final double? subtitleWidth;

  /// Text style
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  /// Spacing
  final double spacing;

  const IconTitleSubtitle({
    super.key,
    required this.title,
    this.subtitle,

    /// layout
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,

    /// subtitle
    this.subtitleMaxLines,
    this.subtitleWidth,

    /// icon
    required this.icon,
    this.iconSize = 20,
    this.iconPadding = const EdgeInsets.all(12),

    /// container style
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius,
    this.shape = BoxShape.rectangle,

    /// text style
    this.titleStyle,
    this.subtitleStyle,

    /// spacing
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Container(
      padding: iconPadding,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            context.theme.colorScheme.outline.withValues(alpha: 0.2),
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? borderRadius ?? BorderRadius.circular(12)
            : null,
        border: Border.all(
          color:
              borderColor ??
              context.theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          width: borderWidth,
        ),
      ),
      child: SizedBox(height: iconSize, width: iconSize, child: icon),
    );

    final textWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        if (subtitle != null)
          SizedBox(
            width: subtitleWidth ?? MediaQuery.of(context).size.width * 0.22,
            child: Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              maxLines: subtitleMaxLines ?? 1,
              style:
                  subtitleStyle ??
                  context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.outline,
                  ),
            ),
          ),
      ],
    );

    return direction == Axis.horizontal
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconWidget,
              SizedBox(width: spacing),
              textWidget,
            ],
          )
        : Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              iconWidget,
              SizedBox(height: spacing),
              textWidget,
            ],
          );
  }
}
