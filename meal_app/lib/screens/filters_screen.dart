import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../providers/filters_provider.dart';
import 'tabs_screen.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The activeFilters variable is used to get the active filters from the filtersProvider provider.
    final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        drawer: MainDrawer(
          onSelcetScreenInDrawer: (identifier) {
            Navigator.of(context).pop();
            if (identifier == 'meals') {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const TabsScreen()),
              );
            }
          },
        ),
        body: Column(
          children: [
            customSwitch(
              context,
              'Gluten-free',
              'Only include gluten-free meals.',
              activeFilters[Filter.glutenFree]!,
              (bool value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, value);
              },
            ),
            customSwitch(
              context,
              'Lactose-free',
              'Only include lactose-free meals.',
              activeFilters[Filter.lactoseFree]!,
              (bool value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, value);
              },
            ),
            customSwitch(
              context,
              'Vegan',
              'Only include vegan meals.',
              activeFilters[Filter.vegan]!,
              (bool value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, value);
              },
            ),
            customSwitch(
              context,
              'Vegetarian',
              'Only include vegetarian meals.',
              activeFilters[Filter.vegeterian]!,
              (bool value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegeterian, value);
              },
            ),
          ],
        ));
  }

// switchListTile is a widget that combines a switch and a list tile. It is commonly used in settings screens to allow users to toggle settings on and off.
  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
      value: filter,
      onChanged: onChanged,
    );
  }
}
