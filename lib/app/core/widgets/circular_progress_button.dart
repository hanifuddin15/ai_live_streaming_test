import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class CircularProgressButton extends StatelessWidget {
  const CircularProgressButton({
    super.key,
    required this.text,
    this.textColor = PRIMARY_COLOR,
    this.backgroundColor = Colors.white,
    this.progressColor = PRIMARY_COLOR,
    this.fontSize = 18,
    required this.onProgressSuccess,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color progressColor;
  final VoidCallback onProgressSuccess;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Rx<int> progressValue = 0.obs;
    Timer? periodicTimer;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTapDown: (tapUpDetail) {
        Timer.periodic(
          const Duration(milliseconds: 30),
          (timer) {
            periodicTimer = timer;
            if (progressValue.value == 3000) {
              timer.cancel();
              progressValue.value = 0;
              onProgressSuccess();
            } else {
              progressValue.value = progressValue.value + 30;
            }
          },
        );
      },
      onTapUp: (tapUpDetails) {
        if (periodicTimer != null) {
          progressValue.value = 0;
          periodicTimer?.cancel();
        }
      },
      child: Obx(() => Container(
            height: Get.width / 2,
            width: Get.width / 2,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: Get.width / 2,
                    width: Get.width / 2,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      color: progressColor,
                      value: progressValue.value / 3000,
                    ),
                  ),
                ),
                Center(
                    child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
