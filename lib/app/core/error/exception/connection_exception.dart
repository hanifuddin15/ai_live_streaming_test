import 'custom_exception.dart';

class ConnectionException extends CustomException {
  ConnectionException({super.message = 'Connection error!'});
}
