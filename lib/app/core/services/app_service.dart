import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';
import 'package:ip_camera_live_streaming/app/core/config/app_assets.dart';
import 'package:ip_camera_live_streaming/app/core/extensions/nullable_object.dart';
import 'package:ip_camera_live_streaming/app/core/services/theme_service.dart';
import 'package:ip_camera_live_streaming/app/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'api_communication.dart';
import 'caching_service.dart';

class AppService {
  AppService._internal();

  static final AppService instance = AppService._internal();

  factory AppService() {
    return instance;
  }

  Future<void> initializeApp() async {
    // Initialize ThemeService
    ThemeService.instance.loadCachedTheme();
    configLoader();

    await CachingService.instance.init();

    final authRepo = AuthRepository();

    final String? token = authRepo.getToken();
    // final String? ipPort = authRepo.getIpPortData();

    ApiCommunication().init(
      token: token ?? 'Not Found',
      ipPort: ApiConstant.serverIpPort,
    );
  }

  void configLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.transparent
      ..boxShadow = []
      ..indicatorWidget = Stack(
        children: [
          Image.asset(
            AppAssets.loaderCircle,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Image.asset(
                AppAssets.loaderIcon,
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      );
  }
}
