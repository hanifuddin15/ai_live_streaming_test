import 'custom_exception.dart';

class UnauthorizedException extends CustomException{
  UnauthorizedException({required super.message});
}