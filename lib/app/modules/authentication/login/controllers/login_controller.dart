import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/extensions/nullable_object.dart';
import 'package:ip_camera_live_streaming/app/core/models/user.dart';
import 'package:ip_camera_live_streaming/app/repository/auth_repository.dart';
import 'package:ip_camera_live_streaming/app/routes/app_pages.dart';

class LoginController extends GetxController {
  late final TextEditingController userIdController;
  late final TextEditingController passwordController;
  Rx<bool> obscureText = true.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final AuthRepository _repository = AuthRepository.instance;

  /*
   * ┏==================================================================================================┓
   * ┃                                         Life Cycle                                               ┃
   * ┗==================================================================================================┛
   */

  @override
  void onInit() {
    super.onInit();
    userIdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    userIdController.dispose();
    passwordController.dispose();
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                          User Events                                             ┃
   * ┗==================================================================================================┛
   */


  void onPressedLogin() {
    String userId = userIdController.text;
    String password = passwordController.text;
    if (loginFormKey.currentState!.validate()) {

        loginUser(userId: userId, password: password);
    }
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                          Network Calls                                           ┃
   * ┗==================================================================================================┛
   */

  Future<void>loginUser({required String userId, required String password}) async {
    UserModel? userModel = await _repository.loginUser(
      userId: userId,
      password: password,
    );
    if (userModel.isNotNullOrEmpty) {
        Get.offAllNamed(Routes.home);
      }
  }
}
