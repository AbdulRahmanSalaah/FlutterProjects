import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dummy_data.dart';

// Create a provider for the meals list using the Provider class. The provider is named mealsProvider.
// The provider returns the dummyMeals list.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
