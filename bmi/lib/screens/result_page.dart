import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../components/result_btn.dart';
import '../controllers/bmi_controller.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    BMIConroller bmiConroller = Get.put(BMIConroller());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back(); // Navigate back to the previous screen
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                    SizedBox(
                        width: 5), // Add some spacing between icon and text
                    Text("Back"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Obx(
                    () => Text(
                      "Your BMI is",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: bmiConroller.colorStattus.value,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: Obx(
                () => CircularPercentIndicator(
                  animationDuration: 1000,
                  footer: Text(
                    bmiConroller.bmiStatus.value,
                    style: TextStyle(
                      color: bmiConroller.colorStattus.value,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  radius: 130,
                  lineWidth: 30,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  // percent: bmiConroller.tempBMI.value / 100,
                  percent: (bmiConroller.tempBMI.value / 50.0).clamp(0.0, 1.0),
                  center: Text(
                    "${bmiConroller.bmi.value}%",
                    style: TextStyle(
                        color: bmiConroller.colorStattus.value,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  progressColor: bmiConroller.colorStattus.value,
                  backgroundColor:
                      bmiConroller.colorStattus.value.withOpacity(0.2),
                ),
              )),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () {
                    // Extract the necessary information from the controller
                    String bmiValue = bmiConroller.bmi.value;
                    String bmiStatus = bmiConroller.bmiStatus.value;
                    // double minWeight = bmiConroller.minWeight.value;
                    // double maxWeight = bmiConroller.maxWeight.value;

                    // Format the dynamic text
                    String dynamicText =
                        "Your BMI is $bmiValue, indicating your weight is in the $bmiStatus category for adults of your height. ";

                    // Return the Text widget with the dynamic content
                    return Text(
                      dynamicText,
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ResultBtn(
                onPress: () {
                  Get.back();
                },
                btnName: "Find Out More",
                icon: Icons.arrow_back_ios_new_outlined,
              )
            ],
          ),
        ),
      ),
    );
  }
}
