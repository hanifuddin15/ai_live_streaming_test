import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../config/app_assets.dart';

void showLoader() {
  EasyLoading.show();
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

void dismissLoader() {
  EasyLoading.dismiss();
}
