import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/repository/auth_repository.dart';
import 'package:ip_camera_live_streaming/app/routes/app_pages.dart';
import 'error_message.dart';
import 'exception/data_missing_exception.dart';
import 'exception/model_conversion_exception.dart';
import 'exception/server_exception.dart';
import 'exception/unauthorized_exception.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handleException(Object exception) {
    if (exception is DioException) {
      return Failure(message: _handleDioException(exception: exception));
    } else if (exception is SocketException) {
      return Failure(message: exception.message);
    } else if (exception is UnauthorizedException) {
      return Failure(message: exception.message);
    } else if (exception is DataMissingException) {
      return Failure(message: exception.message);
    } else if (exception is ServerException) {
      return Failure(message: exception.message);
    } else if (exception is ModelConversionException) {
      return Failure(message: exception.message);
    } else {
      return Failure(message: 'Unknown Error');
    }
  }

  static String _handleDioException({required DioException exception}) {
    if (exception.response?.statusCode == 401) {
      _handleUnauthorizedRequest();
      return 'Unauthorized Request';
    } else {
      dynamic errorResponse = exception.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        String errorMessage =
            errorResponse['message'] ?? 'Something went wrong';
        return errorMessage;
      } else {
        return ErrorMessage.dioExceptionMessage(exceptionType: exception.type);
      }
    }
  }

  static void _handleUnauthorizedRequest() {
    AuthRepository.instance.clearAuthCredential();
    Get.offAllNamed(Routes.login);
  }
}
