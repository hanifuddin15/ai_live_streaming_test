import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import '../texts/custom_text.dart';

class CustomCard extends StatelessWidget {
  final double? height, width;
  final String? cardTitle;

  /// [padding] Empty space inside the card.
  final EdgeInsetsGeometry padding;

  ///
  /// [cardColor] Background color of the card.
  /// [borderColor] Border color of the card.
  ///
  final Color? cardColor, borderColor;

  /// [radius] this double value is used for the border radius of the card.
  final double radius;

  /// [cardContext] contains all widgets inside the card.
  final Widget cardContext;

  const CustomCard({
    super.key,
    this.height,
    this.width,
    this.cardTitle,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 12,
      horizontal: 12,
    ),
    this.cardColor,
    this.borderColor,
    this.radius = 12,
    required this.cardContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: cardColor ?? context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? context.colorScheme.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (cardColor ?? context.colorScheme.surfaceContainer)
                .withValues(alpha: 0.5),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child:
          cardTitle != null
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: cardTitle.toString()),
                  const SizedBox(height: 16),
                  cardContext,
                ],
              )
              : cardContext,
    );
  }
}
