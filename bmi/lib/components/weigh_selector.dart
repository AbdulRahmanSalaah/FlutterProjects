import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bmi_controller.dart';
import 'plus_or_minus_btn.dart';

class WeightSelector extends StatelessWidget {
  const WeightSelector({super.key});

  @override
  Widget build(BuildContext context) {
    BMIConroller bmiConroller = Get.put(BMIConroller());
    return Container(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.only(bottom: 0, top: 27),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Weight",
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  "${bmiConroller.weight.value}",
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlusOrMinusBtn(
                onpress: () {
                  bmiConroller.weight.value--;
                },
                icon: Icons.minimize,
              ),
              PlusOrMinusBtn(
                onpress: () {
                  bmiConroller.weight.value++;
                },
                icon: Icons.add,
              )
            ],
          ),
        ],
      ),
    );
  }
}
