import 'package:flutter/material.dart';

class RequiredTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  const RequiredTitle({
    super.key,
    required this.title,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
