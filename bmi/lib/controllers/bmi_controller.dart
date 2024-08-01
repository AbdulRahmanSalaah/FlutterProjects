import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BMIConroller extends GetxController {
  RxString gender = "MALE".obs;
  RxInt weight = 70.obs;
  RxInt age = 23.obs;
  RxDouble height = 100.0.obs;
  RxString bmi = "".obs;
  RxDouble tempBMI = 0.0.obs;
  RxString bmiStatus = "".obs;
  Rx<Color> colorStattus = const Color(0xff246AFE).obs;
  RxDouble minWeight = 53.5.obs;
  RxDouble maxWeight = 72.0.obs;

  void genderHandle(String newGender) {
    gender.value = newGender;
  }

  void calculatBMI() {
    var hMeter = height / 100; //convert height to meter square
    tempBMI.value = weight / (hMeter * hMeter);
    bmi.value = tempBMI.toStringAsFixed(1);
    tempBMI.value = double.parse(bmi.value);
    findStatus();
    // print(bmi);
  }

  void findStatus() {
    if (tempBMI.value < 18.5) {
      bmiStatus.value = "UnderWeight";
      colorStattus.value = const Color(0xffFFB800);
    }
    if (tempBMI.value > 18.5 && tempBMI.value < 24.9) {
      bmiStatus.value = "Normal";
      colorStattus.value = const Color(0xff00CA39);
      
    }
    if (tempBMI.value > 25.0 && tempBMI.value < 29.9) {
      bmiStatus.value = "OverWeight";
      colorStattus.value = const Color(0xffFF5858);
    }
    if (tempBMI.value > 30.0 && tempBMI.value < 34.9) {
      bmiStatus.value = "OBESE";
      colorStattus.value = const Color(0xffFF0000);
    }
    if (tempBMI.value > 35.0) {
      bmiStatus.value = "Extremely OBESE";

      colorStattus.value = const Color(0xff000000);
    }
  }
}
