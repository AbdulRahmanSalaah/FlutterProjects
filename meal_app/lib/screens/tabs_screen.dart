import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../providers/nav_bar_provider.dart';
import '../widgets/main_drawer.dart';
import 'filters_screen.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> availableMeals = ref.watch(filteredMealsProvider);
    final int selectedPageIndex = ref.watch(navBarProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Pick a Category';

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelcetScreenInDrawer: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'filters') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const FiltersScreen()),
            );
          }
        },
      ),

      // add a BottomNavigationBar widget to the Scaffold widget to switch between the CategoriesScreen and the FavoritesScreen
      bottomNavigationBar: BottomNavigationBar(
        // onTap: _selectPage is called whenever a tab is tapped
        onTap: ref.read(navBarProvider.notifier).selectPage,

        // currentIndex: _selectedPageIndex is used to determine which tab is currently selected
        currentIndex: selectedPageIndex,

        // items: const [] is a list of BottomNavigationBarItem widgets that represent the tabs
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
