import 'package:flutter/material.dart';
import 'package:ip_camera_live_streaming/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}