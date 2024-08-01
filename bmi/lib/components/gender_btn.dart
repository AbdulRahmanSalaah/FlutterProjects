import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bmi_controller.dart';

class GenderBtn extends StatelessWidget {
  const GenderBtn(
      {super.key,
      required this.icon,
      required this.btnName,
      required this.onPress});

  final IconData icon;
  final String btnName;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    BMIConroller bmiConroller = Get.put(BMIConroller());

    return Expanded(
      child: InkWell(
          onTap: onPress,

          // obx is used to update the widget when the value of the variable changes in the controller ,
          // its related to the getx package which is used for state management in the flutter project
          child: Obx(
            () {
              return Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bmiConroller.gender.value == btnName
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: bmiConroller.gender.value == btnName
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      btnName,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: bmiConroller.gender.value == btnName
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
