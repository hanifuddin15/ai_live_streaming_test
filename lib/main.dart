import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:ip_camera_live_streaming/app/core/services/app_service.dart';
import 'package:ip_camera_live_streaming/ip_camera_live_streaming.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppService.instance.initializeApp();

  ansiColorDisabled = false;

  HttpOverrides.global = MyHttpOverrides();

  runApp(const IpCameraLiveStreaming());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
