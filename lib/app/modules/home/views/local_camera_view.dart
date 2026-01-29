
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:ip_camera_live_streaming/app/modules/home/controllers/home_controller.dart';
import 'package:mjpeg_view/mjpeg_view.dart';

class LocalCameraView extends GetView<HomeController> {
  const LocalCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Full Screen Recognition Stream
          Obx(() {
             if (controller.isLocalCameraActive.value) {
                return MjpegView(
                  uri: controller.getLocalStreamUrl(),
                  fit: BoxFit.fitWidth,
                  // loadingBuilder: (_) => const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                );
             }
             return const Center(child: Text("Connecting to AI Stream...", style: TextStyle(color: Colors.white, fontSize: 14)));
          }),

          // 2. Local Preview PIP (Picture in Picture) - Top Right
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            width: 120, // Small preview size
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha:0.5), width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              clipBehavior: Clip.antiAlias,
              child: RTCVideoView(
                controller.localRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                mirror: true,
              ),
            ),
          ),

          // 3. Controls - Bottom
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: [
                // Switch Camera Button
                FloatingActionButton(
                  heroTag: 'switch_cam',
                  backgroundColor: Colors.white24,
                  elevation: 0,
                  onPressed: controller.switchLocalCamera,
                  child: const Icon(Icons.cameraswitch, color: Colors.white),
                ),

                // Stop/Close Button
                FloatingActionButton(
                  heroTag: 'stop_cam',
                  backgroundColor: Colors.red,
                  onPressed: () {
                     controller.stopLocalCamera();
                     Get.back(); // Close view
                  },
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
                
                 // Placeholder for symmetry or other action
                const SizedBox(width: 56), 
              ],
            ),
          ),
          
          // Error Display
           Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 16,
            right: 150, // Avoid PIP
            child: Obx(() {
               if(controller.localStreamError.isNotEmpty) {
                 return Container(
                   padding: const EdgeInsets.all(8),
                   color: Colors.red.withValues(alpha:0.7),
                   child: Text(controller.localStreamError, style: const TextStyle(color: Colors.white, fontSize: 12)),
                 );
               }
               return const SizedBox.shrink();
            }),
          )
        ],
      ),
    );
  }
}
