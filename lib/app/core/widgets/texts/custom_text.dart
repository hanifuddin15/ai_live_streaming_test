import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CustomText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}
