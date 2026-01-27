import '../../extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class IconTextInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;

  const IconTextInfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: context.colorScheme.outline),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style:
                textStyle ??
                context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
