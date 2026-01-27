import 'dart:async';

import 'package:get/get.dart';

import '../../../../repository/auth_repository.dart';
import '../../../../routes/app_pages.dart';

class SplashController {
  void navigate() async {
    AuthRepository repository = AuthRepository();
    Timer(const Duration(seconds: 3), () {
      if (repository.isUserLoggedIn()) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }
}
