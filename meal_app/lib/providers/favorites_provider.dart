import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

// Create a StateNotifier class named FavoritesMealNotifier that extends the StateNotifier class with a type of List<Meal>.
//The class should have a constructor that initializes the state with an empty list.
// The class should also have a method named toggleFavoriteMeal that takes a Meal object as an argument.
class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    final isExisting = state.contains(meal);

    if (isExisting) {
      // the normal remove doesnt work here because the meal object is not the same as the one in the list
      state = List.from(state)..remove(meal);

      return false;
    } else {
      // the normal add doesnt work here because the meal object is not the same as the one in the list
      state = List.from(state)..add(meal);

      return true;
    }
  }
}

// Create a provider for the favorite meals list using the StateNotifierProvider class. The provider is named favoriteMealProvider.
final favoriteMealProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref) {

  // The provider should return an instance of the FavoritesMealNotifier class.
  return FavoritesMealNotifier();
});
