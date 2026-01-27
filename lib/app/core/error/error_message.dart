import 'package:dio/dio.dart';

class ErrorMessage {
  static final ErrorMessage instance = ErrorMessage._();

  ErrorMessage._();

  static const String connectionTimeoutMsg = 'No internet connection';
  static const String unexpectedStatusCodeMsg = 'Unexpected status code';
  static const String sendTimeoutMsg = 'Internet is taking too long time';
  static const String receiveTimeoutMsg = 'Server is taking too long time';
  static const String badCertificateMsg = 'Connection is not secure';
  static const String badResponseMsg = 'Unexpected server response';
  static const String cancelMsg = 'Request was cancelled';
  static const String connectionErrorMsg = 'Cannot reach to the server';
  static const String unknownMsg = 'Something went wrong';

  static String dioExceptionMessage({required DioExceptionType exceptionType}) {
    switch (exceptionType) {
      case DioExceptionType.connectionTimeout:
        return connectionTimeoutMsg;
      case DioExceptionType.sendTimeout:
        return sendTimeoutMsg;
      case DioExceptionType.receiveTimeout:
        return receiveTimeoutMsg;
      case DioExceptionType.badCertificate:
        return badCertificateMsg;
      case DioExceptionType.badResponse:
        return badResponseMsg;
      case DioExceptionType.cancel:
        return cancelMsg;
      case DioExceptionType.connectionError:
        return connectionErrorMsg;
      case DioExceptionType.unknown:
        return unknownMsg;
    }
  }
}
