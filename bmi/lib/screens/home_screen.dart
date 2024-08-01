import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/age_selector.dart';
import '../components/gender_btn.dart';
import '../components/height_selector.dart';
import '../components/result_btn.dart';
import '../components/theme_change_btn.dart';
import '../components/weigh_selector.dart';
import '../controllers/bmi_controller.dart';
import 'result_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BMIConroller bmiConroller = Get.put(BMIConroller());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const ThemeChangeBtn(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Welcome 😊",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GenderBtn(
                    onPress: () {
                      bmiConroller.genderHandle("MALE");
                    },
                    icon: Icons.male,
                    btnName: "MALE",
                  ),
                  const SizedBox(width: 20),
                  GenderBtn(
                    onPress: () {
                      bmiConroller.genderHandle("FEMALE");
                    },
                    icon: Icons.female,
                    btnName: "FEMALE",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeightSelector(),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeightSelector(),
                          AgeSelector(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 35),
              ResultBtn(
                onPress: () {
                  bmiConroller.calculatBMI();
                  Get.to(const ResultPage());
                },
                btnName: "LETS GO",
                icon: Icons.done_all_rounded,
              )
            ],
          ),
        ),
      ),
    );
  }
}
