import 'package:flutter/material.dart';
import 'package:get/get.dart';


const snackbarDuration = Duration(seconds: 2);

void showSnackkbar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Theme.of(Get.context!).colorScheme.primary,
    colorText: Colors.white,
    duration: snackbarDuration,
  );
}

void showSuccessSnackkbar({String? title, required String message}) {
  Get.snackbar(
    title ?? 'SUCCESS!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    duration: snackbarDuration,
  );
}

void showWarningSnackkbar({String? title, required String message}) {
  Get.snackbar(
    title ?? 'WARNING!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.yellow,
    colorText: Colors.black,
    duration: snackbarDuration,
  );
}

void showErrorSnackkbar({String? title, required String message}) {
  Get.snackbar(
    title ?? 'ERROR!',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: snackbarDuration,
  );
}
