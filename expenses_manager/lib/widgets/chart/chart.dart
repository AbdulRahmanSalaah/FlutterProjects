import 'package:flutter/material.dart';

import '../../models/expanses_model.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpansesModel> expenses;

  List<ExpensesBucket> get buckets {
    return [
      ExpensesBucket.forCategory(expenses, Category.food),
      ExpensesBucket.forCategory(expenses, Category.travel),
      ExpensesBucket.forCategory(expenses, Category.leisure),
      ExpensesBucket.forCategory(expenses, Category.work),
    ];
  }

// using the getter buckets to get the total expenses for each category and then getting the maximum total expenses for one category
  get maxTotalExpensesForOneCategory {
    double max = 0;

    for (var bucket in buckets) {
      if (bucket.totalExpenses > max) {
        max = bucket.totalExpenses;
      }
    }

    return max;
  }

  @override
  Widget build(BuildContext context) {
    // Check if the device is in dark mode
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final ele in buckets)
                  ChartBar(
                    fill: ele.totalExpenses == 0
                        ? 0
                        : ele.totalExpenses / maxTotalExpensesForOneCategory,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
