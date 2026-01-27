import 'package:dartz/dartz.dart';
import 'package:ip_camera_live_streaming/app/core/services/api_communication.dart';
import 'package:ip_camera_live_streaming/app/core/services/caching_service.dart';

import '../core/config/api_constant.dart';
import '../core/config/data_key.dart';
import '../core/error/failure.dart';
import '../core/extensions/nullable_object.dart';
import '../core/models/api_response.dart';
import '../core/models/user.dart';

class AuthRepository {
  //* ============================= CHANGE PASSWORD ============================

  AuthRepository._internal();

  static final AuthRepository instance = AuthRepository._internal();

  factory AuthRepository() {
    return instance;
  }

  final CachingService _cachingService = CachingService.instance;
  final ApiCommunication _apiCommunication = ApiCommunication.instance;

  /*
   * ┏==================================================================================================┓
   * ┃                                          Network Calls                                           ┃
   * ┗==================================================================================================┛
   */

  Future<UserModel?> loginUser({
    required String userId,
    required String password,
  }) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'auth/login/',
      requestData: {'email': userId, 'password': password},
      isFormData: false,
      responseDataKey: ApiConstant.fullResponse,
      showSuccessMessage: true,
      addUserData: false,
      successMessage: 'You are successfully logged in',
    );
    if (response.isSuccessful) {
      Map<String, dynamic> fullResponse = response.data as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(fullResponse['results']['user']);
      saveUserData(user);
      String token = fullResponse['results']['accessToken'];
      String refreshToken = fullResponse['results']['refreshToken'];
      cacheAccessToken(token);
      cacheRefreshToken(refreshToken);
      _apiCommunication.updateTokenAndHeader(token);
      return user;
    } else {
      return null;
    }
  }

  Future<Either<Failure, ApiResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Map<String, dynamic> inputData = {
        'oldPassword': currentPassword,
        'newPassword': newPassword,
      };

      ApiResponse response = await _apiCommunication.doPostRequest(
        apiEndPoint: 'Accounts/AcChangePassword',
        responseDataKey: 'data',
        requestData: inputData,
        isFormData: false,
        showSuccessMessage: true,
      );

      if (response.isSuccessful) {
        return Right(response);
      } else {
        return Left(Failure(message: 'Fail to change password'));
      }
    } catch (e) {
      return Left(Failure(message: 'Fail to change password'));
    }
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                       Save Data                                                  ┃
   * ┗==================================================================================================┛
   */

  Future<void> cacheServerCredential({
    required String ipPort,
    required String imagePath,
  }) async {
    await _cachingService.saveData(DataKey.ipPort, ipPort);
    await _cachingService.saveData(DataKey.imagePath, imagePath);
  }

  Future<void> cacheAccessToken(String token) async {
    await _cachingService.saveData(DataKey.accessToken, token);
  }
  Future<void> cacheRefreshToken(String token) async {
    await _cachingService.saveData(DataKey.refreshToken, token);
  }

  Future<void> saveUserData(UserModel model) async {
    await _cachingService.saveData(DataKey.user, model.toJson());
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                         Get Data                                                 ┃
   * ┗==================================================================================================┛
   */

  // String? getIpPortData() {
  //   String? ipPort = _cachingService.getData(DataKey.ipPort);
  //   return ipPort;
  // }

  // String? getImagePathData() {
  //   String? imagePath = _cachingService.getData(DataKey.imagePath);
  //   return imagePath;
  // }

  String? getToken() {
    String? token = _cachingService.getData(DataKey.accessToken);
    return token;
  }

  UserModel? getUserData() {
    final String userJson = _cachingService.getData(DataKey.user);
    if (userJson.isNotNullOrEmpty) {
      UserModel model = UserModel.fromJson(userJson);
      return model;
    } else {
      return null;
    }
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                      Delete Data                                                 ┃
   * ┗==================================================================================================┛
   */

  void clearAuthCredential() async {
    await _cachingService.removeData(DataKey.accessToken);
    await _cachingService.removeData(DataKey.user);
  }
  /*
   * ┏==================================================================================================┓
   * ┃                                      Check Data.                                                 ┃
   * ┗==================================================================================================┛
   */

  bool isUserLoggedIn() {
    if (hasIpPort && hasImagePath && hasToken) {
      return true;
    } else {
      return false;
    }
  }

  bool get hasToken {
    return _cachingService.hasData(DataKey.accessToken);
  }

  bool get hasIpPort {
    return _cachingService.hasData(DataKey.ipPort);
  }

  bool get hasImagePath {
    return _cachingService.hasData(DataKey.imagePath);
  }
}
