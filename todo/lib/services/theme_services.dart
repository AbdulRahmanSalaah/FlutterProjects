import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// extends GetxController for using GetX functionalities like Get.changeThemeMode and Get.isDarkMode
class ThemeServices {
  final GetStorage box = GetStorage();

  final String _key = 'isDarkMode';

  // saveThemeToBox is a method that saves the theme to the box using the key
  saveThemeToBox(bool isDarkMode) {
    return box.write(_key, isDarkMode);
  }

  // loadThemeFromBox is a method that loads the theme from the box using the key
  bool loadThemeFromBox() {
    // if the key is not found, return false as default value 
    return box.read(_key) ?? false; 
  }

  // getThemeMode is a method that returns the theme mode
  ThemeMode getThemeMode() {
    return loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  // changeTheme is a method that changes the theme mode  and saves it to the box
  void changeTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}
