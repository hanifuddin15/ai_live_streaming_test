import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';
import 'package:ip_camera_live_streaming/app/core/models/camera.dart';
import 'package:ip_camera_live_streaming/app/modules/home/controllers/home_controller.dart';
import 'package:ip_camera_live_streaming/app/core/widgets/input_fields/primary_text_form_field.dart';
import 'package:mjpeg_view/mjpeg_view.dart';
import 'package:ip_camera_live_streaming/app/modules/home/views/local_camera_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Control Panel'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Text(
              'Live face recognition + attendance (AI: ${ApiConstant.aiBaseUrl})',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),

            // Error Message
            Obx(() {
              if (controller.error.isNotEmpty) {
               return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    controller.error.value,
                    style: TextStyle(color: Colors.red[700], fontSize: 13),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Add Camera Form
            _buildAddCameraForm(),

            const SizedBox(height: 24),

            // Camera Grid
            LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid logic
                int crossAxisCount = 1;
                if (constraints.maxWidth > 900) crossAxisCount = 4;
                else if (constraints.maxWidth > 600) crossAxisCount = 2;

                return Obx(() {
                  final cams = controller.cameras;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8, // Adjust as needed
                    ),
                    itemCount: cams.length + 1, // +1 for Local Camera
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildLocalCameraCard();
                      }
                      return _buildRemoteCameraCard(cams[index - 1]);
                    },
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCameraForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add CCTV Camera (RTSP)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Add your RTSP camera details to connect a live stream.',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, constraints) {
             bool isWide = constraints.maxWidth > 600;
             return Column(
               children: [
                 if (isWide)
                    Row(
                      children: [
                        Expanded(child: _buildInput(controller.newIdController, 'Camera ID (optional)')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildInput(controller.newNameController, 'Camera Name')),
                        const SizedBox(width: 12),
                        Expanded(flex: 2, child: _buildInput(controller.newUrlController, 'RTSP URL')),
                      ],
                    )
                 else ...[
                    _buildInput(controller.newIdController, 'Camera ID (optional)'),
                    const SizedBox(height: 12),
                    _buildInput(controller.newNameController, 'Camera Name'),
                    const SizedBox(height: 12),
                    _buildInput(controller.newUrlController, 'RTSP URL'),
                 ],
               ],
             );
          }),
          
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.addCamera,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12)
              ),
              child: controller.isLoading.value 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                  : const Text('Add Camera'),
            )),
          )
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint) {
    return PrimaryTextFormField(
      labelText: '',
      hintText: hint,
      textController: controller,
    );
  }

  Widget _buildLocalCameraCard() {
    return Container(
       decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
           Row(
            children: [
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text('Local Camera', style: TextStyle(fontWeight: FontWeight.bold)),
                     const SizedBox(height: 2),
                     Text('Laptop/Device', style: TextStyle(color: Colors.grey[400], fontSize: 10)),
                   ],
                 ),
               ),
               // Start/Stop Button
               Obx(() => SizedBox(
                 height: 28,
                 child: OutlinedButton(
                   onPressed: () async {
                     if (controller.isLocalCameraActive.value) {
                       controller.stopLocalCamera();
                     } else {
                        // Check/Request permissions first before navigation (controller.startLocalCamera handles it, 
                        // but we want to navigate immediately usually or wait?
                        // Let's call startLocalCamera() which starts the stream. 
                        // Once started (or concurrently), we navigate. 
                        // Better to navigate and let the view/controller handle start?
                        // Current startLocalCamera requests permission and starts stream.
                        
                        await controller.startLocalCamera();
                        if (controller.isLocalCameraActive.value) {
                           Get.to(() => const LocalCameraView());
                        }
                     }
                   },
                   style: OutlinedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                     side: BorderSide(color: controller.isLocalCameraActive.value ? Colors.red[200]! : Colors.green[200]!),
                     backgroundColor: controller.isLocalCameraActive.value ? Colors.red[50] : Colors.green[50], 
                   ),
                   child: Text(
                     controller.isLocalCameraActive.value ? 'Stop' : 'Start', 
                     style: TextStyle(
                       fontSize: 12, 
                       color: controller.isLocalCameraActive.value ? Colors.red : Colors.green
                     ),
                   ),
                 ),
               ))
            ],
          ),
          const SizedBox(height: 12),
          // Stream Placeholder (Status Indicator now since view is separate)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Obx(() {
                 // We can still show the stream here if they come back or it's just an indicator
                 if (controller.isLocalCameraActive.value) {
                    return InkWell(
                      onTap: () => Get.to(() => const LocalCameraView()), // Re-open if active
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                           // Preview of recognition only
                           MjpegView(
                            uri: controller.getLocalStreamUrl(),
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              color: Colors.black54,
                              child: const Text("Tap to Open Full Screen", style: TextStyle(color: Colors.white, fontSize: 10)),
                            ),
                          )
                        ],
                      ),
                    );
                 }
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.videocam_off, color: Colors.white54),
                      SizedBox(height: 8),
                      Text('Start camera to view recognition', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                );
              }),
            ),
          ),
          Obx(() {
            if (controller.localStreamError.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  controller.localStreamError,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildRemoteCameraCard(Camera camera) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(camera.name??'N/A', style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('${ApiConstant.aiCameraViewUrl}${camera.rtspUrl??'N/A'}', style: TextStyle(color: Colors.grey[400], fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Start/Stop Button
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: () {
                    if (camera.isActive) {
                      controller.stopCamera(camera);
                    } else {
                      controller.startCamera(camera);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    camera.isActive ? 'Stop' : 'Start', 
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          
          const SizedBox(height: 12),

          // Stream View
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              clipBehavior: Clip.antiAlias,
              child: camera.isActive 
              ? MjpegView(
                  uri: controller.getStreamUrl(camera),
                  fit: BoxFit.cover,
                /*   errorBuilder: (context, error, stackTrace) {
                     return const Center(child: Text('Stream Error', style: TextStyle(fontSize: 10)));
                  },
                  loadingBuilder: (context) {
                     return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  }, */
                )
              : const Center(
                  child: Text('Camera OFF', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
            ),
          ),

          const SizedBox(height: 12),

          // Attendance Controls
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => controller.enableAttendance(camera),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Enable Attendance', style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () => controller.disableAttendance(camera),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Disable Attendance', style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
