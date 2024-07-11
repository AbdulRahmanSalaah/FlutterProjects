import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatefulWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  String get complexityText {
    return widget.meal.complexity.name[0].toUpperCase() +
        widget.meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return widget.meal.affordability.name[0].toUpperCase() +
        widget.meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
          onTap: () => widget.onSelectMeal(widget.meal),
          child: Stack(
            children: [
              // fade in image widget to display the meal image  with a placeholder image while the image is loading

              // The Hero widget is used to create hero animations between different screens.
              // The tag property is a unique identifier for the hero widget.
              // it wraps the FadeInImage widget to create a hero animation between the meal item and the meal details screen.
              Hero(
                tag: widget.meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.meal.imageUrl),
                ),
              ),

              // Positioned widget to position the container at the bottom of the image
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 44,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.meal.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,

                        // The softWrap property is a boolean that controls whether the text should break at soft line breaks.
                        softWrap: true,
                        //  The overflow property is a TextOverflow enum that controls how visual overflow should be handled.
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row widget to display the meal duration, complexity, and affordability
                      // the main row has 3 children rows that display the meal duration, complexity, and affordability
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 17,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.meal.duration} min',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.work,
                                size: 17,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                complexityText,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                size: 17,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                affordabilityText,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )

                      // The Row widget is a parent widget that aligns its children in a horizontal direction.
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
