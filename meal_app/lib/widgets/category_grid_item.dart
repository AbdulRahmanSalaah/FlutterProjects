import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

import '../models/category.dart';
import '../screens/meal_screen.dart';

class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.availableMeals,
  });

  final Category category;
    final List<Meal> availableMeals;




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // InkWell is a Material widget that makes its child interactive. It's useful for adding touch interactions to your widgets.
    return InkWell(
      // The onTap property is a callback that is called when the InkWell is tapped or otherwise activated.
      onTap: () {
        // filtterdMeal is a list of meals that have the same category id as the category that was tapped.
        final List<Meal> filtterdMeal = availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
        // Navigator is a widget that manages a set of child widgets with a stack discipline. It allows you to push and pop widgets onto the stack.
        Navigator.of(context).push(
          // MaterialPageRoute is a modal route that replaces the entire screen with a platform-adaptive transition.
          MaterialPageRoute(
            builder: (ctx) {
              // The MealScreen widget displays a list of meals that have the same category id as the category that was tapped.
              return MealScreen(
                title: category.title,
                meals: filtterdMeal,
              );
            },
          ),
        );
      },

      // The splashColor property is the color of the splash effect that appears when the InkWell is tapped.
      splashColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.7),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
      ),
    );
  }
}
