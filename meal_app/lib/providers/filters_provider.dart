import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegeterian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegeterian: false,
        });

  // This method is used to set the filters
  void setFilters(Map<Filter, bool> chodenFilters) {
    state = chodenFilters;
  }

  // This method is used to set a filter
  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) {
    return FiltersNotifier();
  },
);

final filteredMealsProvider = Provider((ref) {
  // meals is used to get the meals from the mealsProvider provider
  final meals = ref.watch(mealsProvider);

  // activeFilters is used to get the active filters from the filtersProvider provider
  final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);

  // The where method is used to filter the meals based on the active filters
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
