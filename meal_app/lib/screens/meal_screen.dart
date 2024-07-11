import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';

import '../models/meal.dart';
import 'meal_details_screen.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;


  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context),
          );
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          //  loop through the meals list and create a MealItem widget for each meal
          children: [
            for (final meal in meals)

              // The MealItem widget displays the image, title, complexity, and affordability of a meal.
              MealItem(
                meal: meal,
                // The onSelectMeal function is called when a meal is tapped
                onSelectMeal: (meal) {
                  // Navigator is a widget that manages a set of child widgets with a stack discipline. It allows you to push and pop widgets onto the stack.
                  Navigator.of(context).push(
                    // MaterialPageRoute is a modal route that replaces the entire screen with a platform-adaptive transition.
                    MaterialPageRoute(
                      builder: (ctx) {
                        // The MealDetailsScreen widget displays the details of the meal that was tapped.
                        return MealDetailsScreen(
                          meal: meal,
                        
                        );
                      },
                    ),
                  );
                },
              ),
          ]),
    );
  }
}
