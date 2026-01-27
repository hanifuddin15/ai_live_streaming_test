class ApiConstant {
  //API Calling URL
  // static const String SERVER_IP_PORT = 'http://172.16.61.221:8052';
  // static const String BASE_URL = '$SERVER_IP_PORT/api/v1/';

  static const String serverIpPort = 'http://10.81.100.128:3001';
  static const String baseUrl = '$serverIpPort/api/v1/';

  //Request
  static const int listViewPageSize = 10;

  //Response Area.
  static const String fullResponse = 'Full Response';
  static const String dataResponse = 'results';

  //Response Key
  static const String statusCodeKey = 'statusCode';
  static const String totalCount = 'totalCount';
  static const String pagination = 'pagination';
  static const String sampleProfileImageUrl =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
}
