import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigatorKey.currentState!.pop();

}