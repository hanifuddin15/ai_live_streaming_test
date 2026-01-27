import 'package:dartz/dartz.dart';
import 'package:ip_camera_live_streaming/app/core/services/api_communication.dart';
import 'package:ip_camera_live_streaming/app/core/models/camera.dart';
import 'package:ip_camera_live_streaming/app/core/models/api_response.dart';
import 'package:ip_camera_live_streaming/app/core/error/failure.dart';
import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';

class CameraRepository {
  CameraRepository._internal();
  static final CameraRepository instance = CameraRepository._internal();
  factory CameraRepository() => instance;

  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  Future<Either<Failure, List<Camera>>> getCameras() async {
    try {
      final response = await _apiCommunication.doGetRequest(
        apiEndPoint: 'cameras', 
        responseDataKey: ApiConstant.fullResponse, // Use fullResponse for raw List
      );

      if (response.isSuccessful && response.data != null) {
        final List<dynamic> list = response.data as List<dynamic>;
        final cameras = list.map((e) => Camera.fromJson(e)).toList();
        return Right(cameras);
      } else {
        return Left(Failure(message: response.errorMessage ?? 'Failed to fetch cameras'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> addCamera({
    required String name,
    required String rtspUrl,
    String? id,
  }) async {
    try {
      final response = await _apiCommunication.doPostRequest(
        apiEndPoint: 'camera/add', // Assumed endpoint
        requestData: {
          'name': name,
          'rtspUrl': rtspUrl,
          if (id != null && id.isNotEmpty) 'id': id,
        },
        showSuccessMessage: true,
      );

      return Right(response.isSuccessful);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> toggleCameraState(String cameraId, bool isActive) async {
    try {
      final response = await _apiCommunication.doPostRequest(
        apiEndPoint: isActive ? 'camera/start' : 'camera/stop', // Assumed endpoints
        requestData: {'id': cameraId},
        showSuccessMessage: true,
      );
      return Right(response.isSuccessful);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> toggleAttendance(String cameraId, bool enable) async {
    try {
        // Based on page.tsx: enableAttendance / disableAttendance
      final response = await _apiCommunication.doPostRequest(
        apiEndPoint: enable ? 'camera/attendance/enable' : 'camera/attendance/disable', // Assumed endpoints
        requestData: {'id': cameraId},
        showSuccessMessage: true,
      );
      return Right(response.isSuccessful);
    } catch (e) {
       return Left(Failure(message: e.toString()));
    }
  }
}
