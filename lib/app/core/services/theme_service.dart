import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  ThemeService._internal();
  factory ThemeService() {
    return instance;
  }
  static final ThemeService instance = ThemeService._internal();

  static const String _modeCacheKey = 'theme_mode';
  final GetStorage storage = GetStorage();
  Rx<ThemeMode> currentMode = Rx(ThemeMode.light);

  // Load saved theme
  ThemeMode loadCachedTheme() {
    final String? savedThemeMode = storage.read<String?>(_modeCacheKey);
    if (savedThemeMode == null) {
      currentMode.value = ThemeMode.light;
      return currentMode.value;
    } else {
      currentMode.value = ThemeMode.values.firstWhere(
        (e) => e.name == savedThemeMode,
        orElse: () => ThemeMode.light,
      );
      return currentMode.value;
    }
  }

  Future<void> toggleTheme() async {
    currentMode.value =
        (currentMode.value == ThemeMode.dark)
            ? ThemeMode.light
            : ThemeMode.dark;
    // currentMode.refresh();
    await storage.write(_modeCacheKey, currentMode.value.name);
  }
}
