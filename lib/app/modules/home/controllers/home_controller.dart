import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/models/camera.dart';
import 'package:ip_camera_live_streaming/app/repository/camera_repository.dart';
import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';

class HomeController extends GetxController {
  final CameraRepository _repository = CameraRepository.instance;

  // State
  final RxList<Camera> cameras = <Camera>[].obs;
  final RxString error = ''.obs;
  final RxBool isLoading = false.obs;

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

  String getStreamUrl(Camera c) {
    // Logic from page.tsx:
    // ${AI_HOST}/camera/recognition/stream/${encodeURIComponent(c.id)}/${encodeURIComponent(c.name)}${streamQuery}
    
    // We need to construct streamQuery. 
    // const params = new URLSearchParams();
    // params.set("type", "attendance");
    // if (companyId) params.set("companyId", companyId);
    
    // Assuming companyId comes from user token, but implemented simply for now.
    // In page.tsx: const companyId = getCompanyIdFromToken();
    // In our app, we might get it from User model.
    // For now, let's hardcode or leave blank if we don't have it easily accessible, 
    // or fetch from AuthRepository if needed. 
    // Let's assume generic for now.
    
    const baseUrl = ApiConstant.aiCameraViewUrl; 
    final encodedId = Uri.encodeComponent(c.id??'');
    final encodedName = Uri.encodeComponent(c.name??'');
    
    // Query params
    final queryParams = <String, String>{
      'type': 'attendance',
    };
    
    if (c.companyId != null && c.companyId!.isNotEmpty) {
      queryParams['companyId'] = c.companyId!;
    }

    final queryString = Uri(queryParameters: queryParams).query;

    final streamUrl = '$baseUrl$encodedId/$encodedName?$queryString';
    debugPrint('Stream URL for ${c.name}: $streamUrl');
    return streamUrl;
  }
}
