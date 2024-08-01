import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {

  //  this is the controller for the theme change button 
  // obs is used to make the variable reactive 
  RxBool isDark = false.obs;

  void chnageTheme() async {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
