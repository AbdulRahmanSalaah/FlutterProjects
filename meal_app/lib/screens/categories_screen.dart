import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// The SingleTickerProviderStateMixin is a mixin that provides a single Ticker that can be used by a single AnimationController.
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );

    // The forward method starts the animation from its current value to the upper bound.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The AnimatedBuilder widget is useful for more complex animations. It allows you to listen to an animation and rebuild the widget tree when the animation's value changes.
    return AnimatedBuilder(
        animation: _controller,

        // The child property is the child of the AnimatedBuilder widget.
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3 / 2.4,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                availableMeals: widget.availableMeals,
              ),
          ],
        ),

        // The builder property is a callback that is called every time the animation changes.
        builder: (ctx, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(_controller),
            child: child));
  }
}
