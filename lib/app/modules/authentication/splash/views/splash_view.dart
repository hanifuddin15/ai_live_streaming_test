import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_assets.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.navigate();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                top: Get.height / 5,
                child: const Image(
                  height: 192,
                  image: AssetImage(AppAssets.loaderIcon),
                ),
              ),
              Positioned(
                top: Get.height / 1.8,
                child: Stack(
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
                ),
              ),
              Positioned(
                bottom: Get.height / 20,
                child: Column(
                  children: [
                    Text(
                      'Powered by',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'Pakiza Software Limited',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
