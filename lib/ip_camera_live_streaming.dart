import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/config/app_constant.dart';

import 'app/routes/app_pages.dart';

class IpCameraLiveStreaming extends StatelessWidget {
  const IpCameraLiveStreaming({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    /* Obx(
      () => 
     */  
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstant.appName,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
  /*       theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeService.instance.currentMode.value, */
        builder: EasyLoading.init(),
      // ),
    );
  }
}
