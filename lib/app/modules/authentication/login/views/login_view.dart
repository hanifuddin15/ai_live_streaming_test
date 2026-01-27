import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/config/core_validator.dart';
import 'package:ip_camera_live_streaming/app/core/services/theme_service.dart';
import 'package:ip_camera_live_streaming/app/core/utils/color.dart';
import 'package:ip_camera_live_streaming/app/core/widgets/buttons/primary_button.dart';
import 'package:ip_camera_live_streaming/app/core/widgets/input_fields/primary_text_form_field.dart';

import '../../../../core/config/app_assets.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                InkWell(
                  onTap: () async {
                    await ThemeService.instance.toggleTheme();
                  },
                  child: const Image(
                    height: 160,
                    width: 160,
                    image: AssetImage(AppAssets.loaderIcon),
                  ),
                ),
                const SizedBox(height: 64),
                AuthTextFormField(
                  prefixIcon: Icons.person,
                  labelText: 'User Id',
                  textController: controller.userIdController,
                  validator:
                      (value) => CoreValidator.requiredField(
                        value,
                        fieldName: 'User Id',
                      ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => AuthTextFormField(
                    prefixIcon: Icons.lock,
                    labelText: 'Password',
                    textController: controller.passwordController,
                    isPassword: controller.obscureText.value,
                    validator: CoreValidator.passwordField,
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onPressed: controller.onPressedLogin,
                  text: 'LOGIN',
                ),
                const SizedBox(height: 10),
          
                /* const Text(
                  'Powered by',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: PRIMARY_COLOR),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Pakiza Software Limited',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR,
                  ),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
