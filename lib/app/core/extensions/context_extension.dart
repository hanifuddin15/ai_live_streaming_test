import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get themeData => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
