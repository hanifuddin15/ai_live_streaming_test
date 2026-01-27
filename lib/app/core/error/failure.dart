import 'package:ip_camera_live_streaming/app/core/enums/failure_type.dart';


class Failure {
  final FailureType type;
  final String message;
  Failure({required this.message, this.type = FailureType.unexpected});

  String mapFailureToMessage(Failure failure) {
    switch (failure.type) {
      case FailureType.network:
        return 'No internet connection. Please check your network.';
      case FailureType.timeout:
        return 'The request took too long. Try again.';
      case FailureType.server:
        return 'Server is currently unavailable. Please try later.';
      case FailureType.client:
        return 'Invalid request. Please try again.';
      case FailureType.auth:
        return 'Authentication failed. Please log in again.';
      case FailureType.forbidden:
        return 'You don’t have permission to access this resource.';
      case FailureType.validation:
        return 'Some inputs are invalid. Please check and try again.';
      case FailureType.conversion:
        return 'Something went wrong while processing data.';
      case FailureType.permission:
        return 'Permission denied. Please allow access.';
      case FailureType.file:
        return 'File operation failed. Please try again.';
      case FailureType.camera:
        return 'Unable to access camera. Check permissions.';
      case FailureType.notification:
        return 'Notification error occurred.';
      case FailureType.database:
        return 'Database error occurred. Please try again.';
      case FailureType.payment:
        return 'Payment failed. Please try again.';
      case FailureType.location:
        return 'Unable to get location. Please enable GPS.';
      case FailureType.unexpected:
        return 'An unexpected error occurred. Please try again.';
      case FailureType.cache:
        return 'Cache error occurred. Please try again.';
    }
  }
}
