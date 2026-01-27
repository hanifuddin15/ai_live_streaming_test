import 'dart:io';

import 'package:http_parser/http_parser.dart';

MediaType getMediaTypeFromFile(File file) {
  String fileExtension = file.path.split('.').last.toLowerCase();
  if (fileExtension == 'pdf') {
    return MediaType.parse('application/pdf');
  } else if (fileExtension == 'jpeg') {
    return MediaType.parse('image/jpeg');
  } else if (fileExtension == 'png') {
    return MediaType.parse('image/png');
  } else if (fileExtension == 'jpg') {
    return MediaType.parse('image/jpg');
  } else {
    return MediaType.parse('null');
  }
}

String getFileNameFromFile(File file) {
  return file.path.split('/').last;
}
