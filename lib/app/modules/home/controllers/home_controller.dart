import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/models/camera.dart';
import 'package:ip_camera_live_streaming/app/core/services/webrtc_service.dart';
import 'package:ip_camera_live_streaming/app/repository/camera_repository.dart';
import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final CameraRepository _repository = CameraRepository.instance;
  final WebRTCService _webRTCService = Get.put(WebRTCService());

  // State
  final RxList<Camera> cameras = <Camera>[].obs;
  final RxString error = ''.obs;
  final RxBool isLoading = false.obs;

  // Local Camera State
  // "cmkdpsq300000j7284bwluxh2" is the default ID from the React code
  final String localCameraId = "cmkdpsq300000j7284bwluxh2"; 
  final String localCameraName = "Mobile Camera";
  
  RxBool get isLocalCameraActive => _webRTCService.isActive;
  String get localStreamError => _webRTCService.error.value;

  // Form Controllers
  final TextEditingController newIdController = TextEditingController();
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newUrlController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadCameras();
  }

  @override
  void onClose() {
    newIdController.dispose();
    newNameController.dispose();
    newUrlController.dispose();
    super.onClose();
  }

  Future<void> loadCameras() async {
    isLoading.value = true;
    error.value = '';
    
    final result = await _repository.getCameras();
    result.fold(
      (failure) => error.value = failure.message,
      (list) => cameras.assignAll(list),
    );
    
    isLoading.value = false;
  }

  Future<void> addCamera() async {
    final name = newNameController.text.trim();
    final url = newUrlController.text.trim();
    final id = newIdController.text.trim();

    if (name.isEmpty || url.isEmpty) return;

    isLoading.value = true;
    final result = await _repository.addCamera(name: name, rtspUrl: url, id: id);
    isLoading.value = false;

    result.fold(
      (failure) => error.value = failure.message,
      (success) {
        if (success) {
          // Clear form and reload
          newNameController.clear();
          newUrlController.clear();
          newIdController.clear();
          loadCameras();
        }
      },
    );
  }

  Future<void> stopCamera(Camera camera) async {
    // Optimistic update or wait? Let's wait.
    final result = await _repository.toggleCameraState(camera.id??'', false);
    result.fold(
      (failure) => error.value = failure.message,
      (success) {
        if (success) loadCameras(); 
      },
    );
  }

  Future<void> startCamera(Camera camera) async {
    final result = await _repository.toggleCameraState(camera.id??'', true);
    result.fold(
      (failure) => error.value = failure.message,
      (success) {
        if (success) loadCameras();
      },
    );
  }

  Future<void> enableAttendance(Camera camera) async {
    final result = await _repository.toggleAttendance(camera.id??'', true);
    result.fold(
      (failure) => error.value = failure.message,
      (success) {
        if (success) loadCameras();
      },
    );
  }

   Future<void> disableAttendance(Camera camera) async {
    final result = await _repository.toggleAttendance(camera.id??'', false);
    result.fold(
      (failure) => error.value = failure.message,
      (success) {
        if (success) loadCameras();
      },
    );
  }
  
  // Local Camera Methods
  Future<void> startLocalCamera() async {
    // Request Permissions first
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera] != PermissionStatus.granted) {
      error.value = "Camera permission denied";
      return;
    }

    _webRTCService.startStream(
      cameraId: localCameraId,
      companyId: null, // Add if needed
      streamType: 'attendance'
    );
  }

  Future<void> stopLocalCamera() async {
    _webRTCService.stopStream();
  }

  String getStreamUrl(Camera c) {
    return _buildStreamUrl(c.id??'', c.name??'', c.companyId);
  }

  String getLocalStreamUrl() {
    return _buildStreamUrl(localCameraId, localCameraName, null);
  }

  String _buildStreamUrl(String id, String name, String? companyId) {
    const baseUrl = ApiConstant.aiCameraViewUrl; 
    final encodedId = Uri.encodeComponent(id);
    final encodedName = Uri.encodeComponent(name);
    
    // Query params
    final queryParams = <String, String>{
      'type': 'attendance',
    };
    
    if (companyId != null && companyId.isNotEmpty) {
      queryParams['companyId'] = companyId;
    }

    final queryString = Uri(queryParameters: queryParams).query;

    final streamUrl = '$baseUrl$encodedId/$encodedName?$queryString';
    return streamUrl;
  }
}
