import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/utils/color.dart';

class CustomLoader extends StatelessWidget {
  final Widget? child;

  const CustomLoader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return child ??
        Center(
          child: SizedBox(
            height: Get.width / 10,
            width: Get.width / 10,
            child: const CircularProgressIndicator(
              strokeWidth: 5,
              color: primaryColor,
            ),
          ),
        );
  }
}
