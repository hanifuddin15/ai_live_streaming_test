// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// import 'package:flutter/material.dart';

/// Flutter code sample for [CircularProgressIndicator].

class ProgressButton extends StatefulWidget {
  final String title;

  final Callback onTap;
  final Color color;
  const ProgressButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color});

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    //controller.repeat(reverse: false);
    controller.stop();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (tapUpDetail) {
        controller = AnimationController(
          /// [AnimationController]s can be created with `vsync: this` because of
          /// [TickerProviderStateMixin].
          vsync: this,
          duration: const Duration(seconds: 5),
        )..addListener(() {
            setState(() {});
          });
        controller.repeat(reverse: false);
      },
      onTapUp: (tap) {
        controller.stop();
        controller.reset();
        if (controller.value > 0.9) {
          widget.onTap();
        }
      },
      child: SizedBox(
        height: Get.width / 2,
        width: Get.width / 2,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: SizedBox(
                height: Get.width / 2,
                width: Get.width / 2,
                child: CircularProgressIndicator(
                  color: widget.color,
                  value: controller.value,
                  semanticsLabel: 'Circular',
                ),
              ),
            ),
            Positioned(
              left: Get.width / 6,
              top: Get.width / 4.5,
              child: Center(
                  child: Text(
                widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
            )
          ],
        ),
      ),
    );
  }
}
