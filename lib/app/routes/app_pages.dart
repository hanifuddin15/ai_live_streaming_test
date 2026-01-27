

import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/modules/authentication/login/bindings/login_binding.dart';
import 'package:ip_camera_live_streaming/app/modules/authentication/login/views/login_view.dart';
import 'package:ip_camera_live_streaming/app/modules/authentication/splash/bindings/splash_binding.dart';
import 'package:ip_camera_live_streaming/app/modules/authentication/splash/views/splash_view.dart';
import 'package:ip_camera_live_streaming/app/modules/home/bindings/home_binding.dart';
import 'package:ip_camera_live_streaming/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;
  // static const INITIAL = Routes.EXAMPLE_WIDGETS;
  // static const INITIAL = Routes.TEST_BOTTOMSHEET_THEME;

  static final routes = [
    //Testing Theme
    //Text Theme
  
    //-------------------------------------END THEME SCREENS----------------------------//
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    
    
  ];
}
