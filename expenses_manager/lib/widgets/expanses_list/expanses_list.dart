import 'package:expenses_manager/widgets/expanses_list/expanses_item.dart';
import 'package:flutter/material.dart';

import '../../models/expanses_model.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList({
    super.key,

    // The list of expenses to display is passed as a parameter
    required this.expenses,
    required this.removeExpense,
  });

  final void Function(ExpansesModel) removeExpense;

  // The list of expenses to display is stored in the expenses variable
  final List<ExpansesModel> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemCount is the number of items in the list to show in the UI
      itemCount: expenses.length,

      // dismisable is used to make the item dismissable when swiped
      itemBuilder: (context, index) => Dismissible(
        // The key is used to identify the item in the list
        key: ValueKey(expenses[index].id),

        // The direction is used to specify the direction in which the item can be dismissed
        direction: DismissDirection.startToEnd,

        // The background is used to specify the background color of the item when it is dismissed
        background: Container(
          // color: Theme.of(context).errorColor,
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16),
          margin: Theme.of(context).cardTheme.margin,
          // color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),

        // The onDismissed method is called when the item is dismissed
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },

        child: ExpansesItem(
          expanse: expenses[index],
        ),
      ),
    );
  }
}
